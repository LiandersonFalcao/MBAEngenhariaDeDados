
etl_clientes/
├── data/                         # Dados versionados com DVC
│   ├── raw/                     # Dados sintéticos brutos
│   ├── processed/              # Dados transformados
│   └── validated/              # Dados validados
├── expectations/                # Expectation suites (GE)
├── etl/                         # Módulos da aplicação
│   ├── generator.py            # Geração de dados sintéticos
│   ├── loader.py               # Leitura e escrita de arquivos
│   ├── transformer.py          # Limpeza e transformação
│   ├── validator.py            # Validação com GE
│   ├── dvc_manager.py          # Controle de versões com DVC
│   └── exceptions.py           # Exceções personalizadas
├── scripts/
│   └── run_etl.py              # Script principal de execução
├── .dvc/                        # Pasta gerada pelo DVC
├── dvc.yaml                     # Pipeline (posteriormente)
├── requirements.txt             # Dependências do projeto
└── README.md                    # Descrição geral


### Ambiente virtual

python -m venv etl_env
etl_env\Scripts\activate     # Windows

### Dependências
pip install -r requirements.txt


### Inicializa o git e o DVC
git init
dvc init
git commit -m "Inicia projeto com DVC"

### Adicione os stages ao DVC
dvc stage add -n gerar_dados -d etl/generator.py -o data/raw/clientes_raw.csv python scripts/run_etl.py --etapa gerar
dvc stage add -n transformar_dados -d data/raw/clientes_raw.csv -d etl/transformer.py -o data/processed/clientes_processado.csv python scripts/run_etl.py --etapa transformar
dvc stage add -n validar_dados -d data/processed/clientes_processado.csv -d etl/validator.py python scripts/run_etl.py --etapa validar


dvc repro
