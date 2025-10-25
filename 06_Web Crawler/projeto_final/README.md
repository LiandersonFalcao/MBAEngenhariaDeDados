# Projeto de Pipelines ETL - News Feed e Market Data

Este projeto implementa pipelines ETL (Extract, Transform, Load) para coleta e processamento de dados de notícias financeiras e dados de mercado, utilizando uma arquitetura modular e interfaces bem definidas.

## 📋 Visão Geral

O projeto é composto por dois pipelines principais:

### 🔍 News Feed Pipeline
- **Fonte**: InfoMoney (web scraping com Selenium)
- **Função**: Coleta notícias financeiras em tempo real
- **Tecnologias**: Selenium WebDriver, BeautifulSoup
- **Armazenamento**: DuckDB

### 📊 Market Data Pipeline  
- **Fonte**: Yahoo Finance API (YFinance)
- **Função**: Coleta dados históricos de ativos financeiros
- **Tecnologias**: YFinance, Pandas
- **Armazenamento**: DuckDB

## 🏗️ Arquitetura

### Estrutura de Diretórios
```
my_project/
├── bases/                    # Classes base e interfaces
│   ├── crawlers/            # Crawlers base
│   └── interfaces/          # Interfaces ETL
├── config/                  # Configurações
│   ├── logging.py          # Setup de logging
│   └── settings.py         # Configurações gerais
├── news_feed/              # Pipeline de notícias
│   ├── crawler_info_money.py
│   ├── extractor.py
│   ├── transformer.py
│   ├── loader.py
│   └── pipeline.py
├── market_data/            # Pipeline de dados de mercado
│   ├── extractor.py
│   ├── transformer.py
│   ├── loader.py
│   └── pipeline.py
├── data/                   # Banco de dados
│   └── dck.db
├── logs/                   # Logs do sistema
│   └── pipeline.log
└── main.py                 # Ponto de entrada
```

### Padrão ETL Implementado

Cada pipeline segue o padrão ETL com interfaces bem definidas:

1. **Extract** (`ExtractInterface`): Extração de dados das fontes
2. **Transform** (`TransformInterface`): Transformação e limpeza dos dados
3. **Load** (`LoadInterface`): Carregamento no banco de dados

## 🚀 Instalação e Configuração

### Pré-requisitos
- Python 3.8+
- Google Chrome (para web scraping)
- ChromeDriver (gerenciado automaticamente pelo Selenium)

### Instalação

1. **Clone o repositório**:
```bash
git clone <repository-url>
cd my_project
```

2. **Crie um ambiente virtual**:
```bash
python -m venv venv
source venv/bin/activate  # Linux/Mac
# ou
venv\Scripts\activate     # Windows
```

3. **Instale as dependências**:
```bash
pip install -r requirements.txt
```

## 📖 Como Usar

### Execução Completa
Para executar ambos os pipelines sequencialmente:

```bash
python main.py
```

### Execução Individual

#### Pipeline de News Feed
```python
from news_feed.pipeline import NewsFeedPipeline

pipeline = NewsFeedPipeline()
pipeline.execute()
```

#### Pipeline de Market Data
```python
from market_data.pipeline import MarketDataPipeline

pipeline = MarketDataPipeline()
pipeline.execute()
```

### Configurações Personalizadas

#### Market Data Pipeline
```python
# Configurar símbolo e intervalo
pipeline = MarketDataPipeline(
    symbol="AAPL",  # Apple Inc.
    interval="1h"   # Dados por hora
)
pipeline.execute()
```

## 🔧 Configurações

### Logging
O sistema de logging está configurado em `config/logging.py`:
- Logs salvos em `logs/pipeline.log`
- Output também no console
- Nível de log: INFO

### Banco de Dados
- **Tipo**: DuckDB
- **Localização**: `data/dck.db`
- **Criação**: Automática na primeira execução

## 📊 Dados Coletados

### News Feed
- Título da notícia
- URL da notícia
- Data de publicação
- Categoria/tipo
- Conteúdo resumido

### Market Data
- Dados históricos OHLCV (Open, High, Low, Close, Volume)
- Período configurável (padrão: últimos 6 meses)
- Intervalos: 1d, 1h, 5m, etc.

## 🛠️ Desenvolvimento

### Adicionando Novos Extratores
1. Implemente a interface `ExtractInterface`
2. Crie a classe de extração
3. Integre ao pipeline correspondente

### Adicionando Novos Transformadores
1. Implemente a interface `TransformInterface`
2. Defina a lógica de transformação
3. Integre ao pipeline

### Adicionando Novos Loaders
1. Implemente a interface `LoadInterface`
2. Configure a conexão com o destino
3. Integre ao pipeline

## 📝 Logs e Monitoramento

- **Arquivo de log**: `logs/pipeline.log`
- **Formato**: `timestamp [level] [module]: message`
- **Níveis**: INFO, WARNING, ERROR, DEBUG

## 🔍 Troubleshooting

### Problemas Comuns

1. **ChromeDriver não encontrado**:
   - O Selenium gerencia automaticamente o ChromeDriver
   - Certifique-se de ter o Google Chrome instalado

2. **Erro de conexão com YFinance**:
   - Verifique sua conexão com a internet
   - Alguns símbolos podem não estar disponíveis

3. **Erro de permissão no banco**:
   - Verifique se o diretório `data/` existe
   - Verifique permissões de escrita

## 🤝 Contribuição

1. Fork o projeto
2. Crie uma branch para sua feature (`git checkout -b feature/AmazingFeature`)
3. Commit suas mudanças (`git commit -m 'Add some AmazingFeature'`)
4. Push para a branch (`git push origin feature/AmazingFeature`)
5. Abra um Pull Request

## 📄 Licença

Este projeto está sob a licença MIT. Veja o arquivo `LICENSE` para mais detalhes.

## 👥 Autores

- **Lianderson** - *Desenvolvimento inicial* - [@lianderson]

## 🙏 Agradecimentos

- InfoMoney pela disponibilização das notícias
- Yahoo Finance pela API de dados financeiros
- Comunidade Python pelos pacotes utilizados
