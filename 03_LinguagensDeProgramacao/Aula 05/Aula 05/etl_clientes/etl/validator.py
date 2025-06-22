import os
import pandas as pd
import logging
from etl.exceptions import ETLError

class ValidadorClientes:
    def validar(self, caminho_arquivo: str):
        logging.info(f"🔍 Validando o arquivo: {caminho_arquivo}")
        try:
            df = pd.read_csv(caminho_arquivo)
        except Exception as e:
            raise ETLError(f"Erro ao ler CSV: {e}")

        # Verifica colunas obrigatórias
        colunas_necessarias = ["id", "email", "idade"]
        for coluna in colunas_necessarias:
            if coluna not in df.columns:
                raise ETLError(f"Coluna obrigatória ausente: {coluna}")

        # Verifica se email está nulo
        if df["email"].isnull().any():
            raise ETLError("❌ Existem emails nulos no dataset.")

        # Verifica idade
        if not df["idade"].between(18, 100).all():
            raise ETLError("❌ Existem idades fora do intervalo permitido (18 a 100).")

        logging.info("✅ Validação manual concluída com sucesso.")


        caminho_saida = "data/validated/clientes_validado.csv"
        os.makedirs(os.path.dirname(caminho_saida), exist_ok=True)
        df.to_csv(caminho_saida, index=False)
        logging.info(f"📁 Arquivo validado salvo em: {caminho_saida}")