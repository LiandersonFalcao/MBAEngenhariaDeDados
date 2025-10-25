import logging
from datetime import datetime
from bases.interfaces.transformer import TransformInterface

logger = logging.getLogger(__name__)


class NewsFeedTransform(TransformInterface):
    """Transforma e valida os dados extraídos de notícias."""

    REQUIRED_FIELDS = ["tipo_noticia", "titulo_noticia", "url_noticia", "data_noticia"]

    def do_transform(self, **kwargs):
        """Executa a limpeza e validação das notícias extraídas."""
        data_extracted = kwargs.get("data_extracted", {})

        if not data_extracted:
            logger.warning("Nenhum dado fornecido para transformação.")
            return {"data": [], "metadata": {"total_original": 0, "total_valid": 0}}

        news_list = data_extracted.get("data", [])
        extraction_time = data_extracted.get("data_extracao", "N/A")

        logger.info("Iniciando transformação de %d notícias...", len(news_list))

        valid_news = []
        invalid_count = 0

        for i, news in enumerate(news_list):
            if self._is_valid(news):
                news["data_noticia"] = self._normalize_date(news.get("data_noticia"))
                valid_news.append(news)
            else:
                invalid_count += 1
                logger.debug("Notícia %d ignorada — campos obrigatórios ausentes.", i + 1)

        logger.info(
            "Transformação concluída: %d válidas | %d filtradas",
            len(valid_news),
            invalid_count,
        )

        return {
            "data": valid_news,
            "metadata": {
                "total_original": len(news_list),
                "total_valid": len(valid_news),
                "total_filtered": invalid_count,
                "data_extracao": extraction_time,
                "data_transformacao": self._get_current_timestamp(),
            },
        }

    # ------------------------------------------------------------
    def _is_valid(self, news_item):
        """Valida se uma notícia contém todos os campos obrigatórios."""
        if not isinstance(news_item, dict):
            return False

        for field in self.REQUIRED_FIELDS:
            value = news_item.get(field)
            if not value or (isinstance(value, str) and not value.strip()):
                return False
        return True

    def _normalize_date(self, date_value):
        """Converte o campo de data para formato padrão YYYY-MM-DD."""
        try:
            return datetime.strptime(str(date_value), "%d/%m/%Y").strftime("%Y-%m-%d")
        except Exception:
            try:
                return datetime.fromisoformat(str(date_value)).strftime("%Y-%m-%d")
            except Exception:
                return None

    def _get_current_timestamp(self):
        """Retorna o timestamp atual formatado."""
        return datetime.now().strftime("%Y-%m-%d %H:%M:%S")
