import random
import pandas as pd
from faker import Faker

class CarGenerator:
    def __init__(self, n_rows):
        self.n_rows = n_rows
        self.fake = Faker('pt_BR')

    def gerar_carros(self):
        marcas_modelos = {
            "Toyota": ["Corolla", "Hilux", "Etios", "Yaris"],
            "Chevrolet": ["Onix", "Cruze", "S10", "Spin"],
            "Ford": ["Ka", "Fiesta", "EcoSport", "Ranger"],
            "Volkswagen": ["Gol", "Polo", "Virtus", "T-Cross"],
            "Hyundai": ["HB20", "Creta", "Tucson", "i30"],
            "Honda": ["Civic", "Fit", "HR-V", "City"],
            "Fiat": ["Uno", "Mobi", "Argo", "Toro"],
            "Renault": ["Kwid", "Sandero", "Duster", "Logan"]
        }
        cores = ["Preto", "Branco", "Prata", "Vermelho", "Azul", "Cinza"]
        combustiveis = ["Gasolina", "Etanol", "Flex", "Diesel", "Elétrico"]
        cambios = ["Manual", "Automático", "CVT"]

        data = []
        for _ in range(self.n_rows):
            marca = random.choice(list(marcas_modelos.keys()))
            modelo = random.choice(marcas_modelos[marca])
            ano = random.randint(2005, 2025)
            preco_base = random.randint(30, 120) * 1000
            depreciacao = max(0.5, 1 - (2025 - ano) * 0.05)
            preco = round(preco_base * depreciacao, 2)

            data.append({
                "id": self.fake.uuid4(),
                "marca": marca,
                "modelo": modelo,
                "ano": ano,
                "cor": random.choice(cores),
                "quilometragem": random.randint(0, 200_000),
                "preco": preco,
                "combustivel": random.choice(combustiveis),
                "cambio": random.choice(cambios),
                "placa": self.fake.license_plate(),
                "chassi": self.fake.unique.bothify(text='###########??????'),
                "disponivel": random.choice(["Sim", "Não"]),
                "data_cadastro": self.fake.date_this_year()
            })

        return pd.DataFrame(data)