import logging
from bases.interfaces.extractor import ExtractInterface
from news_feed.crawler_info_money import InfoMoneyCrawler

logger = logging.getLogger(__name__)


class NewsFeedExtract(ExtractInterface):
    """Responsável por extrair notícias de fontes externas via crawler."""

    def __init__(self, crawler: InfoMoneyCrawler = None, **kwargs):
        super().__init__(**kwargs)
        self.crawler = crawler or InfoMoneyCrawler(**kwargs)

    def do_extract(self, **kwargs):
        """Executa a extração de notícias usando o InfoMoneyCrawler."""
        logger.info("Iniciando extração de dados de notícias...")

        try:
            # Executa o crawler dentro do contexto (abre e fecha automaticamente o driver)
            with self.crawler as crawler:
                data = crawler.run()

            if not data or not data.get("data"):
                logger.warning("Nenhuma notícia foi retornada pelo crawler.")
            else:
                logger.info("Extração concluída com sucesso: %d registros obtidos.", len(data["data"]))

            return data

        except Exception as err:
            logger.exception("Erro durante a extração de notícias: %s", err)
            raise
