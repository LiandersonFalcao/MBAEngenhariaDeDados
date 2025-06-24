import requests
from tinydb import TinyDB
from datetime import datetime

def extract_dados_bitcoin():
    url = 'https://api.coinbase.com/v2/prices/spot'
    response = requests.get(url)
    dados = response.json()
    return(dados)

def transform_dados_bitcoin(dados):
    cotacao = dados["data"]["amount"]
    moeda = dados["data"]["currency"]
    criptoativo = dados["data"]["base"]
    timestamp = datetime.now().timestamp()

    dados_transformados = {
        "cotacao" : cotacao,
        "moeda": moeda,
        "criptoativo": criptoativo,
        "timestamp": timestamp

    }

    return dados_transformados

def save_dados_bitcoin(dados, db_name="bitcoin.json"):
    db = TinyDB(db_name)
    db.insert(dados)
    print("Dadoa salvos com sucesso!")

if __name__ == "__main__":
    dados_json = extract_dados_bitcoin()
    dados_tratados = transform_dados_bitcoin(dados_json)
    save_dados_bitcoin(dados_tratados)