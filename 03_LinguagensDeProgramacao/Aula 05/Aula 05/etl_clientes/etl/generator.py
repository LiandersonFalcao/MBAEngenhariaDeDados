import pandas as pd
from faker import Faker
import random

class ClienteGenerator:
    def __init__(self, n_rows=100):
        self.n_rows = n_rows
        self.fake = Faker("pt_BR")

    def gerar_clientes(self):
        data = []
        for _ in range(self.n_rows):
            data.append({
                "id": self.fake.uuid4(),
                "nome": self.fake.name(),
                "email": self.fake.email(),
                "telefone": self.fake.phone_number(),
                "endereco": self.fake.address(),
                "idade": random.randint(18, 80),
                "senha": self.fake.password(),
                "score": round(random.uniform(0, 1), 2),
                "data_nascimento": self.fake.date_of_birth(minimum_age=18, maximum_age=80)
            })
        return pd.DataFrame(data)
