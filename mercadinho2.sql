-- Criação do banco de dados
CREATE DATABASE IF NOT EXISTS mercadinho;

-- Seleção do banco de dados a ser utilizado
USE mercadinho;

-- Criação da tabela de usuários
CREATE TABLE IF NOT EXISTS usuarios (
    id INT AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(100) NOT NULL,  -- Nome completo do usuário
    email VARCHAR(100) NOT NULL UNIQUE,  -- Endereço de e-mail único do usuário
    senha VARCHAR(255) NOT NULL,  -- Senha do usuário (armazenada de forma segura)
    endereco TEXT,  -- Endereço completo do usuário
    telefone VARCHAR(20),  -- Número de telefone do usuário
    data_criacao TIMESTAMP DEFAULT CURRENT_TIMESTAMP  -- Data e hora da criação do registro
);

-- Criação da tabela de categorias
CREATE TABLE IF NOT EXISTS categorias (
    id INT AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(100) NOT NULL UNIQUE,  -- Nome da categoria (único)
    descricao TEXT,  -- Descrição da categoria
    data_criacao TIMESTAMP DEFAULT CURRENT_TIMESTAMP  -- Data e hora da criação do registro
);

-- Criação da tabela de produtos
CREATE TABLE IF NOT EXISTS produtos (
    id INT AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(100) NOT NULL,  -- Nome do produto
    descricao TEXT,  -- Descrição do produto
    preco DECIMAL(10, 2) NOT NULL,  -- Preço do produto
    quantidade_estoque INT NOT NULL,  -- Quantidade disponível em estoque
    categoria_id INT,  -- Referência para a categoria do produto
    data_criacao TIMESTAMP DEFAULT CURRENT_TIMESTAMP,  -- Data e hora da criação do registro
    imagem VARCHAR(255),  -- URL ou caminho da imagem do produto
    FOREIGN KEY (categoria_id) REFERENCES categorias(id) ON DELETE CASCADE  -- Relacionamento com a tabela de categorias
);

-- Criação da tabela de estoque
CREATE TABLE IF NOT EXISTS estoque (
    id INT AUTO_INCREMENT PRIMARY KEY,
    produto_id INT,  -- Referência para o produto
    quantidade INT NOT NULL,  -- Quantidade adicionada ao estoque
    data_entrada TIMESTAMP DEFAULT CURRENT_TIMESTAMP,  -- Data e hora da entrada no estoque
    FOREIGN KEY (produto_id) REFERENCES produtos(id) ON DELETE CASCADE  -- Relacionamento com a tabela de produtos
);

-- Criação da tabela de pedidos
CREATE TABLE IF NOT EXISTS pedidos (
    id INT AUTO_INCREMENT PRIMARY KEY,
    usuario_id INT,  -- Referência para o usuário que fez o pedido
    data_pedido TIMESTAMP DEFAULT CURRENT_TIMESTAMP,  -- Data e hora do pedido
    status ENUM('pendente', 'em processamento', 'concluído', 'cancelado') DEFAULT 'pendente',  -- Status do pedido
    total DECIMAL(10, 2) NOT NULL,  -- Valor total do pedido
    FOREIGN KEY (usuario_id) REFERENCES usuarios(id) ON DELETE CASCADE  -- Relacionamento com a tabela de usuários
);

-- Criação da tabela de itens do pedido
CREATE TABLE IF NOT EXISTS itens_pedido (
    id INT AUTO_INCREMENT PRIMARY KEY,
    pedido_id INT,  -- Referência para o pedido
    produto_id INT,  -- Referência para o produto
    quantidade INT NOT NULL,  -- Quantidade do produto no pedido
    preco DECIMAL(10, 2) NOT NULL,  -- Preço do produto no pedido
    FOREIGN KEY (pedido_id) REFERENCES pedidos(id) ON DELETE CASCADE,  -- Relacionamento com a tabela de pedidos
    FOREIGN KEY (produto_id) REFERENCES produtos(id) ON DELETE CASCADE  -- Relacionamento com a tabela de produtos
);

-- Criação da tabela de cliques
CREATE TABLE IF NOT EXISTS cliques (
    id INT AUTO_INCREMENT PRIMARY KEY,
    produto_id INT,  -- Referência para o produto clicado
    timestamp TIMESTAMP DEFAULT CURRENT_TIMESTAMP,  -- Data e hora do clique
    FOREIGN KEY (produto_id) REFERENCES produtos(id) ON DELETE CASCADE  -- Relacionamento com a tabela de produtos
);

-- Criação da tabela de compras
CREATE TABLE IF NOT EXISTS compras (
    id INT AUTO_INCREMENT PRIMARY KEY,
    produto_id INT,  -- Referência para o produto comprado
    quantidade INT NOT NULL,  -- Quantidade do produto comprado
    timestamp TIMESTAMP DEFAULT CURRENT_TIMESTAMP,  -- Data e hora da compra
    FOREIGN KEY (produto_id) REFERENCES produtos(id) ON DELETE CASCADE  -- Relacionamento com a tabela de produtos
);

-- Criação da tabela de carrinhos
CREATE TABLE IF NOT EXISTS carrinhos (
    id INT AUTO_INCREMENT PRIMARY KEY,
    produto_id INT,  -- Referência para o produto adicionado ao carrinho
    quantidade INT NOT NULL,  -- Quantidade do produto no carrinho
    timestamp TIMESTAMP DEFAULT CURRENT_TIMESTAMP,  -- Data e hora da adição ao carrinho
    FOREIGN KEY (produto_id) REFERENCES produtos(id) ON DELETE CASCADE  -- Relacionamento com a tabela de produtos
);

-- Adicionando índices para melhorar o desempenho das consultas
CREATE INDEX idx_cliques_produto ON cliques(produto_id);  -- Índice para a tabela de cliques
CREATE INDEX idx_compras_produto ON compras(produto_id);  -- Índice para a tabela de compras
CREATE INDEX idx_carrinhos_produto ON carrinhos(produto_id);  -- Índice para a tabela de carrinhos
