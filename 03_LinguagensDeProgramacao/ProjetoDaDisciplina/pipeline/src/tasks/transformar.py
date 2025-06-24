import pandas as pd
import logging
from src.exceptions import DataLoadError
import re

class Transformer:
    def __init__(self):
        pass

    def transformar(self, df: pd.DataFrame) -> pd.DataFrame:

        def identificar_padrao_placa(placa):
            """
            Identifica se a placa está no padrão antigo (ABC-1234) ou novo (ABC1D23).
            Retorna 'antigo', 'novo' ou 'inválido'.
            """
            placa = placa.upper().replace('-', '').strip()

            padrao_antigo = re.compile(r'^[A-Z]{3}[0-9]{4}$')
            padrao_novo = re.compile(r'^[A-Z]{3}[0-9][A-Z][0-9]{2}$')

            if padrao_antigo.fullmatch(placa):
                return 'Antigo'
            elif padrao_novo.fullmatch(placa):
                return 'Novo'
            else:
                return 'Inválido'
    
        try:
            logging.info("🧼 Iniciando transformações no DataFrame")

            # Remover duplicatas
            df = df.drop_duplicates()

            # Preencher o CHASSI somente com letras maiúsculas
            df["chassi"] = df["chassi"].str.upper()

            #Classifica o padrão da placa do Carro
            df["padrao_placa"] = df["placa"].apply(identificar_padrao_placa)

            logging.info("✅ Transformações concluídas")
            return df

        except Exception as e:
            logging.error(f"Erro ao transformar dados: {str(e)}")
            raise DataLoadError("Erro na transformação dos dados") from e
