<?php
require_once '../src/Core/Database.php';

// Obter a instância da conexão com o banco de dados
$db = \Core\Database::getInstance();
$pdo = $db->getConnection();

// Buscar categorias
$stmt = $pdo->query("SELECT id, nome FROM categorias");
$categorias = $stmt->fetchAll(PDO::FETCH_ASSOC);

// Buscar produtos
$stmt = $pdo->query("SELECT p.id, p.nome, c.nome AS categoria_nome
                      FROM produtos p
                      JOIN categorias c ON p.categoria_id = c.id");
$produtos = $stmt->fetchAll(PDO::FETCH_ASSOC);
?>

<!DOCTYPE html>
<html lang="pt-BR">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Dashboard</title>
    <link rel="stylesheet" href="style.css"> <!-- Inclua seu CSS aqui -->
    <style>
        .container { max-width: 800px; margin: 0 auto; padding: 20px; }
        .button-group { margin-bottom: 20px; }
        .button-group button { display: block; margin: 10px 0; }
        .form-section { display: none; }
    </style>
    <script>
        function showForm(id) {
            document.querySelectorAll('.form-section').forEach(section => {
                section.classList.remove('active');
            });
            document.getElementById(id).classList.add('active');
        }

    </script>
</head>
<body>
    <div class="container">
        <h1>Dashboard de Produtos</h1>

        <!-- Botões de Ação -->
        <div class="button-group">
            <button onclick="showForm('add_category_form')">Adicionar Categoria</button>
            <button onclick="showForm('remove_category_form')">Remover Categoria</button>
            <button onclick="showForm('add_product_form')">Adicionar Produto</button>
            <button onclick="showForm('remove_product_form')">Remover Produto</button>
            <button onclick="showForm('edit_product_form')">Editar Produto</button>
        </div>

        <!-- Formulários -->
        <!-- Adicionar Categoria -->
        <div id="add_category_form" class="form-section">
            <h2>Adicionar Categoria</h2>
            <form action="infor_produtos.php" method="POST">
                <label for="nome_categoria">Nome da Categoria:</label>
                <input type="text" id="nome_categoria" name="nome_categoria" required>

                <label for="descricao_categoria">Descrição:</label>
                <textarea id="descricao_categoria" name="descricao_categoria" required></textarea>

                <button type="submit" name="add_category">Adicionar Categoria</button>
            </form>
        </div>

        <!-- Remover Categoria -->
        <div id="remove_category_form" class="form-section">
            <h2>Remover Categoria</h2>
            <form action="infor_produtos.php" method="POST">
                <label for="categoria_id">Categoria:</label>
                <select id="categoria_id" name="categoria_id" required>
                    <?php foreach ($categorias as $categoria) : ?>
                        <option value="<?= $categoria['id'] ?>"><?= $categoria['nome'] ?></option>
                    <?php endforeach; ?>
                </select>

                <button type="submit" name="remove_category">Remover Categoria</button>
            </form>
        </div>

        <!-- Adicionar Produto -->
<div id="add_product_form" class="form-section">
    <h2>Adicionar Produto</h2>
    <form action="infor_produtos.php" method="POST" enctype="multipart/form-data">
        <label for="nome_produto">Nome do Produto:</label>
        <input type="text" id="nome_produto" name="nome_produto" required>

        <label for="descricao_produto">Descrição:</label>
        <textarea id="descricao_produto" name="descricao_produto" required></textarea>

        <label for="preco_produto">Preço:</label>
        <input type="number" step="0.01" id="preco_produto" name="preco_produto" required>

        <label for="quantidade_estoque">Quantidade em Estoque:</label>
        <input type="number" id="quantidade_estoque" name="quantidade_estoque" required>

        <label for="categoria_id">Categoria:</label>
        <select id="categoria_id" name="categoria_id" required>
            <?php foreach ($categorias as $categoria) : ?>
                <option value="<?= $categoria['id'] ?>"><?= $categoria['nome'] ?></option>
            <?php endforeach; ?>
        </select>

        <label for="imagem_produto">Imagem:</label>
        <input type="file" id="imagem_produto" name="imagem_produto" accept="image/*" capture="environment">

        <label for="url_imagem_produto">URL da Imagem (opcional):</label>
        <input type="url" id="url_imagem_produto" name="url_imagem_produto">

        <button type="submit" name="add_product">Adicionar Produto</button>
    </form>
</div>


        <!-- Remover Produto -->
        <div id="remove_product_form" class="form-section">
            <h2>Remover Produto</h2>
            <form action="infor_produtos.php" method="POST">
                <label for="produto_id">Produto:</label>
                <select id="produto_id" name="produto_id" required>
                    <?php foreach ($produtos as $produto) : ?>
                        <option value="<?= $produto['id'] ?>"><?= $produto['nome'] ?> - <?= $produto['categoria_nome'] ?></option>
                    <?php endforeach; ?>
                </select>

                <button type="submit" name="remove_product">Remover Produto</button>
            </form>
        </div>

       <!-- Editar Produto -->
<div id="edit_product_form" class="form-section">
    <h2>Editar Produto</h2>
    <form action="infor_produtos.php" method="POST" enctype="multipart/form-data">
        <label for="produto_id">Produto:</label>
        <select id="produto_id" name="produto_id" required>
            <?php foreach ($produtos as $produto) : ?>
                <option value="<?= $produto['id'] ?>"><?= $produto['nome'] ?></option>
            <?php endforeach; ?>
        </select>

        <label for="nome_produto">Nome do Produto:</label>
        <input type="text" id="nome_produto" name="nome_produto" placeholder="Deixe em branco para manter o nome atual">

        <label for="preco_produto">Preço:</label>
        <input type="number" step="0.01" id="preco_produto" name="preco_produto" placeholder="Deixe em branco para manter o preço atual">

        <label for="quantidade_estoque">Quantidade em Estoque:</label>
        <input type="number" id="quantidade_estoque" name="quantidade_estoque" placeholder="Deixe em branco para manter a quantidade atual">

        <label for="categoria_id">Categoria:</label>
        <select id="categoria_id" name="categoria_id">
            <option value="">Deixe em branco para manter a categoria atual</option>
            <?php foreach ($categorias as $categoria) : ?>
                <option value="<?= $categoria['id'] ?>"><?= $categoria['nome'] ?></option>
            <?php endforeach; ?>
        </select>

        <label for="imagem_produto">Imagem:</label>
        <input type="file" id="imagem_produto" name="imagem_produto" accept="image/*" capture="environment">

        <label for="url_imagem_produto">URL da Imagem (opcional):</label>
        <input type="url" id="url_imagem_produto" name="url_imagem_produto">

        <button type="submit" name="edit_product">Editar Produto</button>
    </form>
</div>


        </div>
    </div>
</body>

</html>
