import logging
from news_feed.extractor import NewsFeedExtract
from news_feed.transformer import NewsFeedTransform
from news_feed.loader import NewsFeedLoad

logger = logging.getLogger(__name__)


class NewsFeedPipeline:
    """Pipeline completo para coleta, transformação e carga de notícias."""

    def __init__(self):
        self.extractor = NewsFeedExtract()
        self.transformer = NewsFeedTransform()
        self.loader = NewsFeedLoad()

    def execute(self):
        """Executa o pipeline de ETL para dados de notícias."""
        logger.info("Iniciando pipeline de News Feed...")

        try:
            # -----------------------
            logger.info("Iniciando extração de notícias...")
            data_extracted = self.extractor.do_extract()
            logger.info("Extração concluída com sucesso (%d registros).", len(data_extracted.get("data", [])))

            # -----------------------
            logger.info("Iniciando transformação dos dados...")
            data_transformed = self.transformer.do_transform(data_extracted=data_extracted)
            logger.info("Transformação concluída com sucesso.")

            # -----------------------
            logger.info("Iniciando carga no banco de dados...")
            self.loader.do_load(data_transformed=data_transformed)
            logger.info("Carga concluída com sucesso no banco DuckDB.")

            logger.info("Pipeline de News Feed finalizado com êxito.")

        except Exception as err:
            logger.exception("Falha na execução do pipeline de News Feed: %s", err)
            raise
