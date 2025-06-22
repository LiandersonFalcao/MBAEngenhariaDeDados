# Importando o pacote
import calculo.operacoes

from calculo import operacoes

operacoes.somar()
#print(calculo.operacoes.somar(2, 3))

# Importando diretamente a função
from calculo.operacoes import somar
print(somar(5, 6))

# Importando classe e renomeando
from calculo.operacoes import Calculadora as Calc
c = Calc()
print(c.multiplicar(2, 4))
