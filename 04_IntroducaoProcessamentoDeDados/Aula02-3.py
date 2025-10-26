import time
import concurrent.futures

inicio = time.perf_counter()

def joabe_soma():
    print('Inicio da contagem')
    soma = 0
    for i in range(50_000_000):
        soma += 1
    return('Fim da contagem')

if __name__ == '__main__':
    with concurrent.futures.ProcessPoolExecutor() as executor:
        cod1 = executor.submit(joabe_soma)
        cod2 = executor.submit(joabe_soma)

    print(cod1.result())
    print(cod2.result())



fim = time.perf_counter()
total = round(fim - inicio, 2)
print (f'tempo total:{total}')
