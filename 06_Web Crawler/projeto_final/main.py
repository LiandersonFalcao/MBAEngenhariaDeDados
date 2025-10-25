import sys, logging
from pathlib import Path

PROJECT_ROOT = Path(__file__).resolve().parent
SRC_DIR = PROJECT_ROOT / "src"

for path in (PROJECT_ROOT, SRC_DIR):
    if str(path) not in sys.path:
        sys.path.insert(0, str(path))

from news_feed.pipeline import NewsFeedPipeline
from market_data.pipeline import MarketDataPipeline
from config.logging import setup_logging


def run_news_feed_pipeline():
    """Executa o pipeline de coleta de notícias."""
    logger = logging.getLogger(__name__)
    logger.info("Iniciando pipeline de News Feed...")

    pipeline = NewsFeedPipeline()
    pipeline.execute()

    logger.info("Pipeline de News Feed concluído com sucesso.")


def run_market_data_pipeline():
    """Executa o pipeline de dados de mercado."""
    logger = logging.getLogger(__name__)
    logger.info("Iniciando pipeline de Market Data...")

    pipeline = MarketDataPipeline()
    pipeline.execute()

    logger.info("Pipeline de Market Data concluído com sucesso.")


def main():
    """Executa ambos os pipelines de forma sequencial."""
    setup_logging()
    logger = logging.getLogger(__name__)

    logger.info("Iniciando execução completa dos pipelines (News Feed + Market Data)...")

    try:
        run_news_feed_pipeline() 
        run_market_data_pipeline()
        logger.info("Execução completa de todos os pipelines finalizada com êxito.")
    except Exception as e:
        logger.exception("Erro na execução dos pipelines: %s", e)


if __name__ == "__main__":
    main()
