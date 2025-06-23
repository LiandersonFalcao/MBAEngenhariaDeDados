import sys
import os
sys.path.append(os.path.abspath(os.path.join(os.path.dirname(__file__), "..")))

import argparse
import logging
import time

from src.generator import CarGenerator
from tasks.carregar import DataLoader
from tasks.transformar import Transformer
#from etl.validator import ValidadorClientes
#from etl.exceptions import ETLError


def gerar():
    generator = CarGenerator(n_rows=1000)
    df = generator.gerar_carros()
    loader = DataLoader(base_path="../data/")
    caminho = loader.salvar_csv(df, "input.csv")

    # 🔒 Garante que o arquivo realmente foi criado e é visível
    for _ in range(10):
        if os.path.exists(caminho):
            logging.info(f"✅ Confirmação final: arquivo existe em {caminho}")
            break
        logging.warning("⏳ Aguardando visibilidade do arquivo...")
        time.sleep(0.2)
    else:
        logging.error(f"❌ Arquivo {caminho} não visível após delay!")
        raise Exception("Arquivo de saída não detectado para DVC.")
    

def transformar():
    logging.info("🔧 Etapa: Transformação dos dados")
    loader = DataLoader(base_path="data/raw")
    df = loader.ler_csv("../data/input.csv")
    transformer = Transformer()
    df_limpo = transformer.transformar(df)
    loader = DataLoader(base_path="../data/")
    loader.salvar_csv(df_limpo, "stage.csv")




def main():
    gerar()
    transformar()


if __name__ == "__main__":
    main()