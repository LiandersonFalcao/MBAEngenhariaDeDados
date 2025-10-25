import logging, duckdb
import pandas as pd

from pathlib import Path
from bases.interfaces.loader import LoadInterface
from config.settings import DB_PATH

logger = logging.getLogger(__name__)


class NewsFeedLoad(LoadInterface):

    def __init__(self, **kwargs):
        super().__init__(**kwargs)
        self.db_path = kwargs.get("db_path", DB_PATH)
        self.table_name = kwargs.get("table_name", "news")

        # Garante que o diretório do banco exista
        Path(self.db_path).parent.mkdir(parents=True, exist_ok=True)

    def do_load(self, **kwargs):
        data_transformed = kwargs.get("data_transformed")

        if not data_transformed or not data_transformed.get("data"):
            logger.warning("Nenhum dado fornecido para carga no banco.")
            return False

        df = self._create_dataframe(data_transformed["data"])
        total_records = len(df)
        logger.info("Iniciando carga de %d notícias no banco DuckDB...", total_records)

        conn = None
        try:
            conn = duckdb.connect(self.db_path)
            self._create_news_table(conn)

            # Registra o DataFrame temporariamente
            conn.register("temp_news", df)

            # Insere os registros
            insert_query = f"""
                INSERT INTO {self.table_name} 
                (data_importacao, tipo, titulo, url, data_noticia)
                SELECT data_importacao, tipo, titulo, url, data_noticia FROM temp_news;
            """
            conn.execute(insert_query)

            logger.info("Carga concluída com sucesso (%d registros inseridos).", total_records)
            return True

        except Exception as err:
            logger.exception("Erro durante a carga das notícias: %s", err)
            return False

        finally:
            if conn:
                conn.close()
                logger.debug("Conexão com o banco '%s' encerrada.", self.db_path)

    # ------------------------------------------------------------
    # Tabelas auxiliares
    # ------------------------------------------------------------
    def _create_news_table(self, conn):
        conn.execute("CREATE SEQUENCE IF NOT EXISTS news_id_seq START 1;")
        query = f"""
            CREATE TABLE IF NOT EXISTS {self.table_name} (
                id INTEGER DEFAULT nextval('news_id_seq'),
                data_importacao TIMESTAMP,
                tipo VARCHAR,
                titulo VARCHAR,
                url VARCHAR,
                data_noticia DATE,
                created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
                PRIMARY KEY (id)
            );
        """
        conn.execute(query)
        logger.debug("Tabela '%s' criada/verificada.", self.table_name)

    def _create_dataframe(self, news_list):
        df = pd.DataFrame([
            {
                "data_importacao": pd.Timestamp.now(),
                "tipo": n.get("tipo_noticia", "").strip(),
                "titulo": n.get("titulo_noticia", "").strip(),
                "url": n.get("url_noticia", "").strip(),
                "data_noticia": self._parse_date(n.get("data_noticia"))
            }
            for n in news_list
        ])

        logger.debug("DataFrame criado com %d registros e colunas: %s", len(df), df.columns.tolist())
        return df

    def _parse_date(self, value):
        try:
            return pd.to_datetime(value, errors="coerce").date()
        except Exception:
            return None
