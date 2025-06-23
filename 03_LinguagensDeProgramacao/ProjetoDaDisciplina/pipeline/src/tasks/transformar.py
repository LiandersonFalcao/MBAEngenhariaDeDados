import pandas as pd
import logging
from src.exceptions import DataLoadError
import re

class Transformer:
    def __init__(self):
        pass

    def classificar_placa(placa):
        placa = placa.strip().upper()
        if re.match(r'^[A-Z]{3}-\d{4}$', placa):
            return "Antigo"
        elif re.match(r'^[A-Z]{3}\d[A-Z]\d{2}$', placa):
            return "Mercosul"
        else:
            return "Inválido"

    def transformar(self, df: pd.DataFrame) -> pd.DataFrame:

        def classificar_placa(placa):
            placa = placa.strip().upper()
            if re.match(r"^[A-Z]{3}[0-9]{4}$", placa):
                return "Antigo"
            elif re.match(r"^[A-Z]{3}[0-9]{1}[A-Z]{1}[0-9]{2}$", placa):
                return "Mercosul"
            else:
                return "Inválido"
    
        try:
            logging.info("🧼 Iniciando transformações no DataFrame")

            # Remover duplicatas
            df = df.drop_duplicates()

            # Preencher o CHASSI somente com letras maiúsculas
            df["chassi"] = df["chassi"].str.upper()

            #Classifica o padrão da placa do Carro
            df["padrao_placa"] = df["placa"].apply(classificar_placa)

            # Garantir que idade seja numérica e válida
            #df["idade"] = pd.to_numeric(df["idade"], errors="coerce")
            #df = df[df["idade"].between(18, 100)]

            # Remover espaços dos nomes
            #df["nome"] = df["nome"].str.strip()

            # Substituir senhas vazias
            #df["senha"] = df["senha"].replace("", "123456")

            # Score padrão se ausente
            #df["score"] = pd.to_numeric(df["score"], errors="coerce").fillna(0.5)

            logging.info("✅ Transformações concluídas")
            return df

        except Exception as e:
            logging.error(f"Erro ao transformar dados: {str(e)}")
            raise DataLoadError("Erro na transformação dos dados") from e
