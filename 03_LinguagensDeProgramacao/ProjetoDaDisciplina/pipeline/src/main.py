import sys
import os
sys.path.append(os.path.abspath(os.path.join(os.path.dirname(__file__), "..")))

import argparse
import logging
import time

from tasks.extrair import CarGenerator
from tasks.carregar import DataLoader
from tasks.transformar import Transformer

logging.basicConfig(
    level=logging.INFO,
    format="%(asctime)s - [%(levelname)s] %(message)s",
)

#extrair.py
def extrair():
    logging.info("Gerando Input de Dados Aleatório!")
    generator = CarGenerator(n_rows=1000)
    df = generator.gerar_carros()
    loader = DataLoader(base_path="../data/")
    caminho = loader.salvar_csv(df, "input.csv")

#transformar.py
def transformar():
    logging.info("Iniciando a etapa de Tratamento de Dados")
    loader = DataLoader(base_path="../data/")
    df = loader.ler_csv("../data/input.csv")
    transformer = Transformer()
    df_limpo = transformer.transformar(df)
    loader = DataLoader(base_path="../data/")
    loader.salvar_csv(df_limpo, "stage.csv")

#carregar.py
def carregar():
    logging.info("Iniciando a etapa de Tratamento de Dados")
    loader = DataLoader(base_path="../data/")
    df = loader.ler_csv("../data/stage.csv")
    loader = DataLoader(base_path="../data/")
    loader.salvar_csv(df, "output.csv")

def main():
    extrair()
    transformar()
    carregar()

if __name__ == "__main__":
    main()