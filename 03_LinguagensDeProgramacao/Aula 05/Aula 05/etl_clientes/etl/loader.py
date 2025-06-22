
import os
import pandas as pd
import time
from etl.exceptions import DataLoadError

class DataLoader:
    def __init__(self, base_path: str = "data/raw"):
        self.base_path = base_path
        os.makedirs(self.base_path, exist_ok=True)  # Garante que o diretório existe

    def salvar_csv(self, df: pd.DataFrame, nome_arquivo: str) -> str:
        try:
            caminho = os.path.join(self.base_path, nome_arquivo)
            df.to_csv(caminho, index=False, encoding="utf-8")

            # Força sincronização do sistema de arquivos
            with open(caminho, 'a', encoding='utf-8') as f:
                f.flush()
                os.fsync(f.fileno())

            # Delay curto para garantir visibilidade no Windows
            time.sleep(0.1)

            print(f"[DEBUG] Arquivo salvo em: {caminho}")
            return caminho.replace("\\", "/")  # Compatível com DVC
        except Exception as e:
            raise DataLoadError(f"Erro ao salvar arquivo CSV: {str(e)}")

    def ler_csv(self, caminho: str) -> pd.DataFrame:
        try:
            return pd.read_csv(caminho)
        except Exception as e:
            raise DataLoadError(f"Erro ao ler arquivo CSV: {str(e)}")
