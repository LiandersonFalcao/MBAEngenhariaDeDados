
import pandas as pd
import time
from sqlalchemy import create_engine
import numpy as np
import concurrent.futures

df_escolas = pd.read_csv('/fontes/dataset_escolas.csv')
df_estudantes = pd.read_csv('/fontes/dataset_estudantes.csv')

df_merged = pd.merge(df_estudantes, df_escolas, on='Nome_Escola', how='left')

def joabe_particiona(partes_df):
    partes_df = partes_df.copy()
    partes_df['Aprovado'] = np.where(partes_df['Nota_Matematica']>= 7, 'Aprovado', 'Reprovado')
    return partes_df

if __name__ == '__main__':
    inicio = time.perf_counter()
    partes = np.array_split(df_merged, 4)

    with concurrent.futures.ProcessPoolExecutor() as executor:
        resultados = list(executor.map(joabe_particiona, partes))

    df_final = pd.concat(resultados, ignore_index=True)

    fim = time.perf_counter()
    total = round(fim - inicio, 2)
    print (f'tempo total:{total}')
    
    usuario = 'postgres'
    senha = 'sa'
    host = 'localhost'
    database = 'joabe_db'
    port = '5432'

    engine = create_engine(f'postgresql+psycopg2://{usuario}:{senha}@{host}:{port}/{database}')

    df_merged.to_sql(df_final, engine, if_exists='replace', index=False)