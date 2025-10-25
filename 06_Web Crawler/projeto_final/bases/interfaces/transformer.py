from abc import ABC, abstractmethod


class TransformInterface(ABC):
    """Interface base para todos os transformadores do sistema."""

    @abstractmethod
    def do_transform(self, **kwargs):
        """Executa a transformação dos dados extraídos."""
        raise NotImplementedError("O método 'do_transform' deve ser implementado pela subclasse.")
