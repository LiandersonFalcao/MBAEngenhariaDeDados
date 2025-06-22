# validadores/base.py
# ABC = Abstract Base Classes
from abc import ABC, abstractmethod

class Validador(ABC):
    @abstractmethod
    def validar(self, dado):
        pass
