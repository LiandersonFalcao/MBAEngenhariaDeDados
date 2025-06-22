import sys
import os
sys.path.append(os.path.abspath(os.path.join(os.path.dirname(__file__), "..")))

import argparse
import logging
import time

from etl.generator import ClienteGenerator
from etl.loader import DataLoader
from etl.transformer import Transformer
from etl.validator import ValidadorClientes
from etl.exceptions import ETLError

logging.basicConfig(
    level=logging.INFO,
    format="%(asctime)s - [%(levelname)s] %(message)s",
)


def gerar():
    logging.info("🔧 Etapa: Geração de dados sintéticos")
    generator = ClienteGenerator(n_rows=100)
    df = generator.gerar_clientes()
    loader = DataLoader(base_path="data/raw")
    caminho = loader.salvar_csv(df, "clientes_raw.csv")

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
    df = loader.ler_csv("data/raw/clientes_raw.csv")
    transformer = Transformer()
    df_limpo = transformer.transformar(df)
    loader = DataLoader(base_path="data/processed")
    loader.salvar_csv(df_limpo, "clientes_processado.csv")


def validar():
    logging.info("🔧 Etapa: Validação dos dados com Great Expectations")
    validador = ValidadorClientes()
    validador.validar("data/processed/clientes_processado.csv")


def main():
    parser = argparse.ArgumentParser()
    parser.add_argument("--etapa", choices=["gerar", "transformar", "validar"], required=True)
    args = parser.parse_args()

    try:
        if args.etapa == "gerar":
            gerar()
        elif args.etapa == "transformar":
            transformar()
        elif args.etapa == "validar":
            validar()
    except ETLError as e:
        logging.error(f"Erro na etapa {args.etapa}: {str(e)}")
        raise
    except Exception as e:
        logging.error(f"Erro inesperado: {str(e)}")
        raise


if __name__ == "__main__":
    main()
