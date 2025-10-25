import logging
import duckdb
import pandas as pd
from pathlib import Path
from bases.interfaces.loader import LoadInterface
from config.settings import DB_PATH

logger = logging.getLogger(__name__)


class MarketDataLoad(LoadInterface):
    """Carrega dados de mercado no banco DuckDB (tabelas instruments e prices)."""

    def __init__(self, **kwargs):
        super().__init__(**kwargs)
        self.db_path = kwargs.get("db_path", DB_PATH)
        self.table_instruments = kwargs.get("table_instruments", "instruments")
        self.table_prices = kwargs.get("table_prices", "prices")

        # Garante que o diretório do banco exista
        Path(self.db_path).parent.mkdir(parents=True, exist_ok=True)

    def do_load(self, **kwargs):
        """Executa a carga dos dados transformados nas tabelas de mercado."""
        df = kwargs.get("df")
        symbol = kwargs.get("symbol", "BTC-USD")

        if df is None or df.empty:
            logger.warning("Nenhum dado fornecido para carga no banco.")
            return False

        logger.info("Iniciando carga de %d registros para o ativo '%s'...", len(df), symbol)
        conn = None

        try:
            conn = duckdb.connect(self.db_path)

            # Criação das tabelas se não existirem
            self._create_instruments_table(conn)
            self._create_prices_table(conn)

            # Garante que o instrumento está registrado
            self._ensure_instrument_exists(conn, symbol)

            # Registra o DataFrame temporariamente
            df["symbol"] = symbol
            conn.register("temp_df", df)

            # Verifica correspondência de colunas
            table_cols = [row[1] for row in conn.execute(f"PRAGMA table_info({self.table_prices});").fetchall()]
            df_cols = [c for c in df.columns if c in table_cols]
            if not df_cols:
                logger.error("Nenhuma coluna do DataFrame corresponde ao schema da tabela '%s'.", self.table_prices)
                return False

            cols_str = ", ".join(df_cols)
            insert_query = f"INSERT INTO {self.table_prices} ({cols_str}) SELECT {cols_str} FROM temp_df"
            conn.execute(insert_query)

            logger.info("Carga concluída: %d registros inseridos na tabela '%s'.", len(df), self.table_prices)
            return True

        except Exception as err:
            logger.exception("Erro durante a carga de dados: %s", err)
            return False

        finally:
            if conn:
                conn.close()
                logger.debug("Conexão com o banco '%s' encerrada.", self.db_path)

    # ------------------------------------------------------------
    # Tabelas auxiliares
    # ------------------------------------------------------------
    def _create_instruments_table(self, conn):
        """Cria a tabela instruments se não existir."""
        conn.execute("CREATE SEQUENCE IF NOT EXISTS instruments_id_seq START 1;")
        query = f"""
            CREATE TABLE IF NOT EXISTS {self.table_instruments} (
                id INTEGER DEFAULT nextval('instruments_id_seq'),
                symbol VARCHAR UNIQUE,
                name VARCHAR,
                sector VARCHAR,
                created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
                PRIMARY KEY (id)
            );
        """
        conn.execute(query)
        logger.debug("Tabela '%s' criada/verificada.", self.table_instruments)

    def _create_prices_table(self, conn):
        """Cria a tabela prices se não existir."""
        conn.execute("CREATE SEQUENCE IF NOT EXISTS prices_id_seq START 1;")
        query = f"""
            CREATE TABLE IF NOT EXISTS {self.table_prices} (
                id INTEGER DEFAULT nextval('prices_id_seq'),
                symbol VARCHAR,
                date DATE,
                open DOUBLE,
                high DOUBLE,
                low DOUBLE,
                close DOUBLE,
                adj_close DOUBLE,
                volume BIGINT,
                pct_change DOUBLE,
                ma_7d DOUBLE,
                ma_30d DOUBLE,
                created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
                PRIMARY KEY (id)
            );
        """
        conn.execute(query)
        logger.debug("Tabela '%s' criada/verificada.", self.table_prices)

    def _ensure_instrument_exists(self, conn, symbol):
        """Verifica se o ativo existe em instruments; caso contrário, insere."""
        query = f"SELECT COUNT(*) FROM {self.table_instruments} WHERE symbol = ?"
        exists = conn.execute(query, [symbol]).fetchone()[0]

        if not exists:
            conn.execute(
                f"INSERT INTO {self.table_instruments} (symbol, name, sector) VALUES (?, ?, ?)",
                [symbol, symbol, "Unknown"]
            )
            logger.info("Novo instrumento registrado: %s", symbol)
        else:
            logger.debug("Instrumento '%s' já registrado.", symbol)
