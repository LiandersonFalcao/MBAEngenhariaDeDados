import logging,time

from market_data.extractor import MarketDataExtract
from market_data.transformer import MarketDataTransform
from market_data.loader import MarketDataLoad

logger = logging.getLogger(__name__)


class MarketDataPipeline:
    """Pipeline responsável por orquestrar o ETL de dados de mercado (YFinance ou outras fontes)."""

    def __init__(self, **kwargs):
        self.extractor = kwargs.get("extractor", MarketDataExtract())
        self.transformer = kwargs.get("transformer", MarketDataTransform())
        self.loader = kwargs.get("loader", MarketDataLoad())

    def execute(self, **kwargs):
        start_time = time.perf_counter()
        logger.info("Iniciando pipeline de ETL para dados de mercado...")

        try:
            # ----- 
            logger.info("Iniciando extração dos dados de mercado...")
            data = self.extractor.do_extract()
            logger.info("Extração concluída com sucesso (%d registros).", len(data))

            # ----- 
            logger.info("Iniciando transformação dos dados extraídos...")
            transformed_data = self.transformer.do_transform(df=data)
            logger.info("Transformação concluída. %d registros processados.", len(transformed_data))

            # ----- 
            logger.info("Iniciando carga dos dados no banco DuckDB...")
            self.loader.do_load(df=transformed_data)
            logger.info("Carga concluída com sucesso no banco '%s'.", self.loader.db_path)

            duration = time.perf_counter() - start_time
            logger.info("Pipeline de dados de mercado finalizado em %.2fs", duration)

        except Exception as e:
            logger.exception("Erro durante a execução do pipeline de dados de mercado: %s", e)
            raise
