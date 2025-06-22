# main.py
from validadores import ValidadorEmail


validador = ValidadorEmail()
print(validador.validar("teste@email.com"))

