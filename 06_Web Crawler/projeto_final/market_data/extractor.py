import logging
from datetime import datetime, timedelta
import yfinance as yf
from bases.interfaces.extractor import ExtractInterface

logger = logging.getLogger(__name__)


class MarketDataExtract(ExtractInterface):
    """Extrai dados históricos de ativos financeiros via API YFinance."""

    def __init__(self, **kwargs):
        super().__init__(**kwargs)
        self.symbol = kwargs.get("symbol", "BTC-USD")
        self.interval = kwargs.get("interval", "1d")

    def do_extract(self):
        """Obtém os dados históricos do ativo a partir da API do Yahoo Finance."""
        start_time = datetime.now()
        logger.info("Iniciando extração de dados para o ativo %s (%s)...", self.symbol, self.interval)

        try:
            end_date = datetime.today()
            start_date = end_date - timedelta(days=180)  # Últimos 6 meses

            logger.debug("Período solicitado: %s → %s", start_date.date(), end_date.date())

            df = yf.download(
                self.symbol,
                start=start_date.strftime("%Y-%m-%d"),
                end=end_date.strftime("%Y-%m-%d"),
                interval=self.interval,
                multi_level_index=False
            )

            if df.empty:
                logger.warning("Nenhum dado foi retornado pela API do YFinance para %s.", self.symbol)
                return df

            logger.info("Extração concluída com sucesso: %d registros obtidos.", len(df))
            logger.debug("Colunas retornadas: %s", list(df.columns))

            df.reset_index(inplace=True)
            return df

        except Exception as err:
            logger.exception("Erro durante a extração de dados do YFinance: %s", err)
            raise

        finally:
            elapsed = (datetime.now() - start_time).total_seconds()
            logger.info("Tempo total de extração: %.2fs", elapsed)
