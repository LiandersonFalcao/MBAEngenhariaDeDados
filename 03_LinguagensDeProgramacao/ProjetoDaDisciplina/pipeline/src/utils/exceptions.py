class ETLError(Exception):
    """Exceção base para erros do ETL."""
    pass

class DataLoadError(ETLError):
    """Erro ao carregar ou salvar dados."""
    pass

class ValidationError(ETLError):
    """Erro durante a validação dos dados."""
    pass
