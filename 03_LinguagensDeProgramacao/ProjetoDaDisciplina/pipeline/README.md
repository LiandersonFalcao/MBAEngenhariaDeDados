🚗 ETL de Dados da Loja de Carros
Este projeto realiza um processo completo de ETL (Extração, Transformação e Carga) de dados fictícios de uma loja de carros. O objetivo é centralizar, limpar e transformar informações sobre veículos, para facilitar análises e tomada de decisões.

📂 Estrutura do Projeto
pipeline/
├── src/
│   ├── main.py                # Executável principal
│   ├── task.py                # Definição da classe base Task
│   ├── pipeline.py            # Definição da classe Pipeline
│   ├── tasks/
│   │   ├── extrair.py         # Tarefa: Extração
│   │   ├── transformar.py     # Tarefa: Transformação
│   │   └── carregar.py        # Tarefa: Carga
│   └── utils/
│       └── logger.py          # Funções auxiliares (log, tempo, etc)
├── data/
│   ├── input.csv              # Dados de entrada simulados\
│   ├── stage.csv              # Dados processados\
│   └── output.csv             # Dados analíticos
├── logs/
│   └── execucao.log           # Log de execuções da pipeline
├── dvc.yaml                   # Controle de versão dos dados
├── .pre-commit-config.yaml    # Hooks de qualidade
├── README.md
└── requirements.txt           # Versões das bibliotecas usadas no projeto

🔧 Tecnologias Utilizadas
Python 3.10+
pandas

⚙️ Como Executar
Clone o repositório:

git clone https://github.com/LiandersonFalcao/MBAEngenhariaDeDados.git
[03_LinguagensDeProgramacao/ProjetoDaDisciplina/]

Crie e ative um ambiente virtual (opcional, mas recomendado):

python -m venv venv
.venv\Scripts\activate

Instale as dependências:
pip install -r requirements.txt

Execute o pipeline:

python main.py