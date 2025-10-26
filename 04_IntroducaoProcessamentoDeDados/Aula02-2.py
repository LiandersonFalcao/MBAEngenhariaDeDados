import time
import multiprocessing

inicio = time.perf_counter()

def joabe_soma():
    print('Inicio da contagem')
    soma = 0
    for i in range(50_000_000):
        soma += 1
    print('Fim da contagem')
    print(soma)

fim = time.perf_counter()

total = round(fim - inicio, 2)

print (f'tempo total:{total}')

if __name__ == '__main__':
    inicio = time.perf_counter()

    cod1 = multiprocessing.Process(target=joabe_soma)
    cod2 = multiprocessing.Process(target=joabe_soma)

    cod1.start()
    cod2.start()

    cod1.join()
    cod2.join()

    fim = time.perf_counter()

    total = round(fim - inicio, 2)

    print (f'tempo total:{total}')
