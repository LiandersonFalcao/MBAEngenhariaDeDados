# validadores/email.py
from .base import Validador

class ValidadorEmail(Validador):
    def validar(self, dado):
        return "@" in dado
