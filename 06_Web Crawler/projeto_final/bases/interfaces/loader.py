from abc import ABC, abstractmethod


class LoadInterface(ABC):
    """Interface base para todos os carregadores do sistema."""

    @abstractmethod
    def do_load(self, **kwargs):
        """Executa a carga dos dados transformados no destino."""
        raise NotImplementedError("O método 'do_load' deve ser implementado pela subclasse.")
