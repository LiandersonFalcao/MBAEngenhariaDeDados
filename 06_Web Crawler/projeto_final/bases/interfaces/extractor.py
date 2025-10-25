from abc import ABC, abstractmethod


class ExtractInterface(ABC):
    """Interface base para todos os extratores do sistema."""

    @abstractmethod
    def do_extract(self, **kwargs):
        """Executa a extração dos dados brutos da fonte."""
        raise NotImplementedError("O método 'do_extract' deve ser implementado pela subclasse.")
