import duckdb

DB_PATH = "data/dck.db"  # ajuste o caminho se necessário

conn = duckdb.connect(DB_PATH)

tables = conn.execute("SHOW TABLES").fetchall()
print("\n📂 Tabelas encontradas no banco:")
for t in tables:
    print(f"  - {t[0]}")

for t in tables:
    print(f"\n🔎 Prévia da tabela '{t[0]}':")
    try:
        df = conn.execute(f"SELECT * FROM {t[0]} LIMIT 5").fetchdf()
        print(df)
    except Exception as e:
        print(f"Erro ao consultar '{t[0]}': {e}")

print("\n📊 Contagem de registros:")
for t in tables:
    count = conn.execute(f"SELECT COUNT(*) FROM {t[0]}").fetchone()[0]
    print(f"  - {t[0]}: {count} registros")

conn.close()
