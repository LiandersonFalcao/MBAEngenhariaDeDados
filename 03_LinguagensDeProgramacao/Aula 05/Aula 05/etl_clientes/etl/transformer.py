import pandas as pd
import logging
from etl.exceptions import DataLoadError

class Transformer:
    def __init__(self):
        pass

    def transformar(self, df: pd.DataFrame) -> pd.DataFrame:
        try:
            logging.info("🧼 Iniciando transformações no DataFrame")

            # Remover duplicatas
            df = df.drop_duplicates()

            # Preencher e padronizar emails
            df["email"] = df["email"].fillna("sem_email@dominio.com").str.lower()

            # Garantir que idade seja numérica e válida
            df["idade"] = pd.to_numeric(df["idade"], errors="coerce")
            df = df[df["idade"].between(18, 100)]

            # Remover espaços dos nomes
            df["nome"] = df["nome"].str.strip()

            # Substituir senhas vazias
            df["senha"] = df["senha"].replace("", "123456")

            # Score padrão se ausente
            df["score"] = pd.to_numeric(df["score"], errors="coerce").fillna(0.5)

            logging.info("✅ Transformações concluídas")
            return df

        except Exception as e:
            logging.error(f"Erro ao transformar dados: {str(e)}")
            raise DataLoadError("Erro na transformação dos dados") from e
