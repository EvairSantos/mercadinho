-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Tempo de geração: 22/08/2024 às 06:43
-- Versão do servidor: 10.4.32-MariaDB
-- Versão do PHP: 8.2.12

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Banco de dados: `mercadinho`
--

-- --------------------------------------------------------

--
-- Estrutura para tabela `carrinhos`
--

CREATE TABLE `carrinhos` (
  `id` int(11) NOT NULL,
  `produto_id` int(11) DEFAULT NULL,
  `quantidade` int(11) NOT NULL,
  `timestamp` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Estrutura para tabela `categorias`
--

CREATE TABLE `categorias` (
  `id` int(11) NOT NULL,
  `nome` varchar(100) NOT NULL,
  `descricao` text DEFAULT NULL,
  `data_criacao` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Despejando dados para a tabela `categorias`
--

INSERT INTO `categorias` (`id`, `nome`, `descricao`, `data_criacao`) VALUES
(12, 'Alimentos', 'Frutas, legumes, carnes, laticínios e mais.', '2024-08-22 03:21:25'),
(13, 'Produtos de Limpeza', 'Detergentes, desinfetantes e produtos para limpeza geral.', '2024-08-22 03:21:25'),
(14, 'Higiene Pessoal', 'Sabonetes, shampoos e produtos de cuidados pessoais.', '2024-08-22 03:21:25'),
(15, 'Mercearia', 'Enlatados, produtos secos e snacks.', '2024-08-22 03:21:25'),
(16, 'Bebidas Alcoólicas', 'Cervejas, vinhos e destilados.', '2024-08-22 03:21:25'),
(17, 'Produtos para Bebês', 'Fraldas, alimentos e cuidados para bebês.', '2024-08-22 03:21:25'),
(18, 'Farmácia e Saúde', 'Medicamentos, suplementos e primeiros socorros.', '2024-08-22 03:21:25'),
(19, 'Congelados', 'Comidas prontas e produtos congelados.', '2024-08-22 03:21:25'),
(20, 'Padaria', 'Pães frescos, bolos e tortas.', '2024-08-22 03:21:25');

-- --------------------------------------------------------

--
-- Estrutura para tabela `cliques`
--

CREATE TABLE `cliques` (
  `id` int(11) NOT NULL,
  `produto_id` int(11) DEFAULT NULL,
  `timestamp` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Estrutura para tabela `compras`
--

CREATE TABLE `compras` (
  `id` int(11) NOT NULL,
  `produto_id` int(11) DEFAULT NULL,
  `quantidade` int(11) NOT NULL,
  `timestamp` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Estrutura para tabela `estoque`
--

CREATE TABLE `estoque` (
  `id` int(11) NOT NULL,
  `produto_id` int(11) DEFAULT NULL,
  `quantidade` int(11) NOT NULL,
  `data_entrada` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Estrutura para tabela `itens_pedido`
--

CREATE TABLE `itens_pedido` (
  `id` int(11) NOT NULL,
  `pedido_id` int(11) DEFAULT NULL,
  `produto_id` int(11) DEFAULT NULL,
  `quantidade` int(11) NOT NULL,
  `preco` decimal(10,2) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Estrutura para tabela `pedidos`
--

CREATE TABLE `pedidos` (
  `id` int(11) NOT NULL,
  `usuario_id` int(11) DEFAULT NULL,
  `data_pedido` timestamp NOT NULL DEFAULT current_timestamp(),
  `status` enum('pendente','em processamento','concluído','cancelado') DEFAULT 'pendente',
  `total` decimal(10,2) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Estrutura para tabela `produtos`
--

CREATE TABLE `produtos` (
  `id` int(11) NOT NULL,
  `nome` varchar(100) NOT NULL,
  `descricao` text DEFAULT NULL,
  `preco` decimal(10,2) NOT NULL,
  `quantidade_estoque` int(11) NOT NULL,
  `categoria_id` int(11) DEFAULT NULL,
  `data_criacao` timestamp NOT NULL DEFAULT current_timestamp(),
  `imagem` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Despejando dados para a tabela `produtos`
--

INSERT INTO `produtos` (`id`, `nome`, `descricao`, `preco`, `quantidade_estoque`, `categoria_id`, `data_criacao`, `imagem`) VALUES
(4, 'CERVEJA SKOL', 'Este é um teste de cerveja skol', 15.00, 10, 16, '2024-08-21 16:49:57', 'https://cf.shopee.com.br/file/676cbf40cc4e59fd1a91d5fd63dcab5e'),
(5, 'Feijão Carioca Cores Kicaldo Em Pacote Sem Glúten 1 Kg', 'O que você precisa saber sobre este produto\r\n\r\n    Unidades por kit: 1\r\n    Tipo de embalagem: Pacote\r\n    Peso líquido: 1 kg\r\n    Sem glúten.\r\n    Embalagem de 1 kg.', 6.89, 20, 12, '2024-08-21 21:13:19', 'img/66c6586f07313.webp'),
(7, 'Óleo De Soja Liza Pet 900ml', 'Teste', 7.15, 20, 15, '2024-08-21 21:15:23', 'https://http2.mlstatic.com/D_NQ_NP_2X_921239-MLB46177469161_052021-F.webp'),
(8, 'Vinho Seival By Miolo Tempranillo 750ml', 'Vinho Seival By Miolo Tempranillo 750ml Kit 6 Unidades', 236.00, 12, 16, '2024-08-21 21:18:23', 'https://http2.mlstatic.com/D_NQ_NP_2X_628642-MLB75839788067_042024-F.webp'),
(9, 'Jagermeíster 1 Litro Original', '    Linha: Licor\r\n\r\n    Sabores: Wisky e Creme\r\n\r\n    Tipo de licor: Fino\r\n\r\n    Formato de venda: Unidade\r\n\r\n    Volume líquido: 1 L\r\n\r\n    Tipo de embalagem: Garrafa\r\n\r\n    Graduação alcoólica: 35 %\r\n\r\n    Origem: Alemanha\r\n\r\n    Inclui estojo: Não\r\n\r\n    É uma bebida sem álcool: Não', 159.90, 12, 16, '2024-08-21 21:21:47', 'https://http2.mlstatic.com/D_NQ_NP_2X_901081-MLB70728735971_072023-F.webp'),
(10, 'Arroz Branco Coradini Pacote 5kg', 'Arroz Branco Coradini Pacote 5kg TiPo 1', 38.15, 10, 15, '2024-08-21 22:55:21', 'https://s3.amazonaws.com/produtos.vipcommerce.com.br/250x250/ac2be29a-dd3b-4187-ad12-cdc50e055902.jpg'),
(11, 'Tempero Em Pó Sazon', ' Sachê 60g Feijao', 6.15, 10, 15, '2024-08-21 22:57:46', 'https://s3.amazonaws.com/produtos.vipcommerce.com.br/250x250/a6c41811-cf4f-4408-b259-ebf815e65a30.jpg'),
(12, 'Amido De Milho Kimimo', 'Caixa 200G', 5.85, 5, 15, '2024-08-21 23:04:14', 'https://s3.amazonaws.com/produtos.vipcommerce.com.br/250x250/688f62b2-3a7c-4af6-9121-f635924fcb6c.jpg'),
(13, 'Creme Dental Colgate 180g', 'Tripla Acao - Preco Especial', 10.99, 20, 15, '2024-08-21 23:09:01', 'https://s3.amazonaws.com/produtos.vipcommerce.com.br/144x144/d57f098e-f49b-4216-80d0-5a59c9df9338.jpg'),
(14, 'Creme Dental Colgate 90g', 'Tripla Acao Menta Original', 8.39, 10, 15, '2024-08-21 23:12:17', 'https://s3.amazonaws.com/produtos.vipcommerce.com.br/250x250/b23262e4-219d-447a-ba16-284487a89feb.jpg'),
(15, 'Leite Longa Vida Piracanjuba Tp', '1l Semidesnatado', 9.15, 10, 15, '2024-08-21 23:16:31', 'https://s3.amazonaws.com/produtos.vipcommerce.com.br/250x250/f7485b72-f405-4795-895b-4b56fab35e47.jpg'),
(16, 'Oleo De Girassol Sinha Pet 900ml', 'Pet 900ml', 12.87, 10, 15, '2024-08-21 23:20:21', 'https://s3.amazonaws.com/produtos.vipcommerce.com.br/250x250/fd57d8dc-8b59-490a-828d-e1f2ca1ef6b8.jpg'),
(17, 'Ovos Brancos', 'Cart 30 Un Medio', 21.35, 10, 12, '2024-08-21 23:23:31', 'https://s3.amazonaws.com/produtos.vipcommerce.com.br/144x144/f3ffd1cb-e9b1-43b4-bfc7-307b778877ed.jpg'),
(18, 'Ovos Vermelhos', 'Cart 30 Un Grande', 30.35, 10, 12, '2024-08-21 23:24:39', 'https://s3.amazonaws.com/produtos.vipcommerce.com.br/250x250/9c34d1c9-4203-4351-a4e9-c6e08fa92908.jpg'),
(19, 'Biscoito Salgado Mammamia', 'Pct 117,6g Original', 3.15, 10, 15, '2024-08-21 23:27:15', 'https://s3.amazonaws.com/produtos.vipcommerce.com.br/144x144/65205fa3-e6e1-47c9-a9e3-976047e91d24.jpg'),
(20, 'Iogurte Nestlé', 'Garrafa 1,25kg Morango', 23.75, 10, 15, '2024-08-21 23:31:44', 'https://s3.amazonaws.com/produtos.vipcommerce.com.br/250x250/e50207c7-a7f2-4a32-b906-dace44d22d87.jpg'),
(21, 'Amaciante Diluído Ypê', ' 2l Azul Intenso', 14.29, 10, 13, '2024-08-21 23:33:31', 'https://s3.amazonaws.com/produtos.vipcommerce.com.br/250x250/39e76e35-7351-4fc4-828f-3f49c9e92b3c.jpg');

-- --------------------------------------------------------

--
-- Estrutura para tabela `usuarios`
--

CREATE TABLE `usuarios` (
  `id` int(11) NOT NULL,
  `nome` varchar(100) NOT NULL,
  `email` varchar(100) NOT NULL,
  `senha` varchar(255) NOT NULL,
  `endereco` text DEFAULT NULL,
  `telefone` varchar(20) DEFAULT NULL,
  `data_criacao` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Índices para tabelas despejadas
--

--
-- Índices de tabela `carrinhos`
--
ALTER TABLE `carrinhos`
  ADD PRIMARY KEY (`id`),
  ADD KEY `idx_carrinhos_produto` (`produto_id`);

--
-- Índices de tabela `categorias`
--
ALTER TABLE `categorias`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `nome` (`nome`);

--
-- Índices de tabela `cliques`
--
ALTER TABLE `cliques`
  ADD PRIMARY KEY (`id`),
  ADD KEY `idx_cliques_produto` (`produto_id`);

--
-- Índices de tabela `compras`
--
ALTER TABLE `compras`
  ADD PRIMARY KEY (`id`),
  ADD KEY `idx_compras_produto` (`produto_id`);

--
-- Índices de tabela `estoque`
--
ALTER TABLE `estoque`
  ADD PRIMARY KEY (`id`),
  ADD KEY `produto_id` (`produto_id`);

--
-- Índices de tabela `itens_pedido`
--
ALTER TABLE `itens_pedido`
  ADD PRIMARY KEY (`id`),
  ADD KEY `pedido_id` (`pedido_id`),
  ADD KEY `produto_id` (`produto_id`);

--
-- Índices de tabela `pedidos`
--
ALTER TABLE `pedidos`
  ADD PRIMARY KEY (`id`),
  ADD KEY `usuario_id` (`usuario_id`);

--
-- Índices de tabela `produtos`
--
ALTER TABLE `produtos`
  ADD PRIMARY KEY (`id`),
  ADD KEY `categoria_id` (`categoria_id`);

--
-- Índices de tabela `usuarios`
--
ALTER TABLE `usuarios`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `email` (`email`);

--
-- AUTO_INCREMENT para tabelas despejadas
--

--
-- AUTO_INCREMENT de tabela `carrinhos`
--
ALTER TABLE `carrinhos`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de tabela `categorias`
--
ALTER TABLE `categorias`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=21;

--
-- AUTO_INCREMENT de tabela `cliques`
--
ALTER TABLE `cliques`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de tabela `compras`
--
ALTER TABLE `compras`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de tabela `estoque`
--
ALTER TABLE `estoque`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de tabela `itens_pedido`
--
ALTER TABLE `itens_pedido`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de tabela `pedidos`
--
ALTER TABLE `pedidos`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de tabela `produtos`
--
ALTER TABLE `produtos`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=23;

--
-- AUTO_INCREMENT de tabela `usuarios`
--
ALTER TABLE `usuarios`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- Restrições para tabelas despejadas
--

--
-- Restrições para tabelas `carrinhos`
--
ALTER TABLE `carrinhos`
  ADD CONSTRAINT `carrinhos_ibfk_1` FOREIGN KEY (`produto_id`) REFERENCES `produtos` (`id`) ON DELETE CASCADE;

--
-- Restrições para tabelas `cliques`
--
ALTER TABLE `cliques`
  ADD CONSTRAINT `cliques_ibfk_1` FOREIGN KEY (`produto_id`) REFERENCES `produtos` (`id`) ON DELETE CASCADE;

--
-- Restrições para tabelas `compras`
--
ALTER TABLE `compras`
  ADD CONSTRAINT `compras_ibfk_1` FOREIGN KEY (`produto_id`) REFERENCES `produtos` (`id`) ON DELETE CASCADE;

--
-- Restrições para tabelas `estoque`
--
ALTER TABLE `estoque`
  ADD CONSTRAINT `estoque_ibfk_1` FOREIGN KEY (`produto_id`) REFERENCES `produtos` (`id`) ON DELETE CASCADE;

--
-- Restrições para tabelas `itens_pedido`
--
ALTER TABLE `itens_pedido`
  ADD CONSTRAINT `itens_pedido_ibfk_1` FOREIGN KEY (`pedido_id`) REFERENCES `pedidos` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `itens_pedido_ibfk_2` FOREIGN KEY (`produto_id`) REFERENCES `produtos` (`id`) ON DELETE CASCADE;

--
-- Restrições para tabelas `pedidos`
--
ALTER TABLE `pedidos`
  ADD CONSTRAINT `pedidos_ibfk_1` FOREIGN KEY (`usuario_id`) REFERENCES `usuarios` (`id`) ON DELETE CASCADE;

--
-- Restrições para tabelas `produtos`
--
ALTER TABLE `produtos`
  ADD CONSTRAINT `produtos_ibfk_1` FOREIGN KEY (`categoria_id`) REFERENCES `categorias` (`id`) ON DELETE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
