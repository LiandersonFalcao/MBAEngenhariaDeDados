# validadores/__init__.py
#     pasta.arquivo             classe/funcao/variavel
from .email import ValidadorEmail
from .senha import ValidadorSenha

__all__ = ["ValidadorEmail"]
