-- Inserindo navios
INSERT INTO navios (id, nome, capacidade_kg) VALUES
(1, 'Titanic II', 500000),
(2, 'Poseidon', 450000),
(3, 'Nautilus', 400000);
GO

-- Inserindo portos
INSERT INTO portos (id, nome, endereco) VALUES
(1, 'Porto de Santos', 'Santos - SP'),
(2, 'Porto de Salvador', 'Salvador - BA'),
(3, 'Porto de Manaus', 'Manaus - AM'),
(4, 'Porto de Fortaleza', 'Fortaleza - CE');
GO

-- Inserindo rotas
INSERT INTO rotas (id, id_navio, id_porto_origem, id_porto_destino, data_prevista_chegada) VALUES
(1, 1, 1, 2, '2025-06-10'),
(2, 1, 2, 3, '2025-06-15'),
(3, 2, 3, 4, '2025-06-20'),
(4, 3, 4, 1, '2025-06-25');
GO

-- Inserindo agentes
INSERT INTO agentes (id, nome, id_porto, eh_supervisor) VALUES
(1, 'João Silva', 1, 1),
(2, 'Maria Souza', 2, 0),
(3, 'Carlos Lima', 3, 1),
(4, 'Ana Rocha', 4, 0);
GO

-- Inserindo cargas (20 registros)
INSERT INTO cargas (id, numero, id_navio, descricao, especificacao, data_inicio, data_final, data_validade, status, eh_sensivel, eh_perecivel) VALUES
(1, 'C001', 1, 'Eletrônicos', 'TVs e computadores', '2025-05-01', '2025-05-10', '2025-06-01', 'Em trânsito', 1, 0),
(2, 'C002', 1, 'Roupas', 'Moda inverno', '2025-05-01', '2025-05-11', NULL, 'Em trânsito', 0, 0),
(3, 'C003', 2, 'Medicamentos', 'Vacinas', '2025-05-02', '2025-05-12', '2025-06-05', 'Em trânsito', 1, 1),
(4, 'C004', 3, 'Alimentos', 'Produtos perecíveis', '2025-05-02', '2025-05-13', '2025-05-25', 'Em trânsito', 0, 1),
(5, 'C005', 2, 'Cosméticos', 'Frascos de perfume', '2025-05-03', '2025-05-14', '2025-06-10', 'Em trânsito', 0, 0),
(6, 'C006', 3, 'Máquinas', 'Equipamentos industriais', '2025-05-04', '2025-05-15', NULL, 'Em trânsito', 0, 0),
(7, 'C007', 1, 'Bebidas', 'Refrigerantes e sucos', '2025-05-04', '2025-05-15', '2025-06-05', 'Em trânsito', 0, 1),
(8, 'C008', 2, 'Móveis', 'Cadeiras e mesas', '2025-05-05', '2025-05-16', NULL, 'Em trânsito', 0, 0),
(9, 'C009', 3, 'Automóveis', 'Peças de reposição', '2025-05-06', '2025-05-17', NULL, 'Em trânsito', 0, 0),
(10, 'C010', 1, 'Livros', 'Material didático', '2025-05-07', '2025-05-18', NULL, 'Em trânsito', 0, 0),
(11, 'C011', 2, 'Celulares', 'Smartphones', '2025-05-08', '2025-05-19', '2025-07-01', 'Em trânsito', 1, 0),
(12, 'C012', 3, 'Peixes', 'Produtos congelados', '2025-05-09', '2025-05-20', '2025-05-30', 'Em trânsito', 0, 1),
(13, 'C013', 1, 'Produtos químicos', 'Inflamáveis', '2025-05-10', '2025-05-21', '2025-06-10', 'Em trânsito', 1, 0),
(14, 'C014', 2, 'Fertilizantes', 'Uso agrícola', '2025-05-11', '2025-05-22', NULL, 'Em trânsito', 0, 0),
(15, 'C015', 3, 'Computadores', 'Servidores e peças', '2025-05-12', '2025-05-23', '2025-07-01', 'Em trânsito', 1, 0),
(16, 'C016', 1, 'Carne bovina', 'Produtos resfriados', '2025-05-13', '2025-05-24', '2025-05-29', 'Em trânsito', 0, 1),
(17, 'C017', 2, 'Material hospitalar', 'Equipamentos médicos', '2025-05-14', '2025-05-25', NULL, 'Em trânsito', 1, 0),
(18, 'C018', 3, 'Vinhos', 'Importados', '2025-05-15', '2025-05-26', '2025-06-30', 'Em trânsito', 0, 1),
(19, 'C019', 1, 'Plásticos', 'Matéria-prima', '2025-05-16', '2025-05-27', NULL, 'Em trânsito', 0, 0),
(20, 'C020', 2, 'Produtos têxteis', 'Tecidos diversos', '2025-05-17', '2025-05-28', NULL, 'Em trânsito', 0, 0);
GO

-- Inserindo etiquetas (relacionadas às cargas e agentes/portos)
INSERT INTO etiquetas (id, id_carga, id_porto_origem, id_porto_destino, id_agente, peso, temperatura_maxima, data_prevista_entrega) VALUES
(1, 1, 1, 2, 1, 1200.50, 25.0, '2025-06-05'),
(2, 2, 1, 3, 2, 800.00, NULL, '2025-06-06'),
(3, 3, 3, 4, 3, 600.00, 8.0, '2025-06-07'),
(4, 4, 4, 1, 4, 900.00, 4.0, '2025-06-08'),
(5, 5, 3, 2, 2, 1100.00, NULL, '2025-06-09'),
(6, 6, 2, 1, 1, 1500.00, NULL, '2025-06-10'),
(7, 7, 1, 3, 3, 1000.00, 6.0, '2025-06-11'),
(8, 8, 3, 2, 2, 2000.00, NULL, '2025-06-12'),
(9, 9, 4, 1, 1, 1700.00, NULL, '2025-06-13'),
(10, 10, 1, 2, 4, 500.00, NULL, '2025-06-14'),
(11, 11, 2, 3, 3, 850.00, 22.0, '2025-06-15'),
(12, 12, 3, 4, 4, 400.00, -2.0, '2025-06-16'),
(13, 13, 4, 1, 1, 1300.00, 10.0, '2025-06-17'),
(14, 14, 1, 4, 2, 1400.00, NULL, '2025-06-18'),
(15, 15, 2, 3, 3, 900.00, 20.0, '2025-06-19'),
(16, 16, 3, 2, 2, 1000.00, 4.0, '2025-06-20'),
(17, 17, 4, 3, 3, 800.00, NULL, '2025-06-21'),
(18, 18, 3, 1, 1, 600.00, 16.0, '2025-06-22'),
(19, 19, 1, 2, 1, 1200.00, NULL, '2025-06-23'),
(20, 20, 2, 4, 4, 1500.00, NULL, '2025-06-24');
GO
