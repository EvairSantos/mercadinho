<?php
// Inclui o arquivo de configuração do banco de dados
require_once '../src/Core/Database.php';

// Obtém a conexão com o banco de dados
$pdo = \Core\Database::getInstance()->getConnection();

// Função para obter o histórico de cliques ou compras do usuário
function getUserHistory($pdo, $userId) {
    $stmt = $pdo->prepare("SELECT produto_id FROM cliques WHERE usuario_id = :user_id GROUP BY produto_id ORDER BY COUNT(*) DESC LIMIT 30");
    $stmt->execute(['user_id' => $userId]);
    return $stmt->fetchAll(PDO::FETCH_COLUMN);
}

// Verifica se o usuário está autenticado e obtém o ID do usuário
session_start();
$userId = isset($_SESSION['user_id']) ? intval($_SESSION['user_id']) : null;

// Obtém os produtos e categorias
$produtos = $pdo->query("SELECT * FROM produtos")->fetchAll(PDO::FETCH_ASSOC);
$categorias = $pdo->query("SELECT * FROM categorias")->fetchAll(PDO::FETCH_ASSOC);

// Obtém o histórico de produtos mais clicados ou comprados para o usuário autenticado
$historicoIds = [];
if ($userId) {
    $historicoIds = getUserHistory($pdo, $userId);
}

// Filtra os produtos com base no histórico (exemplo: exibir primeiro os mais clicados/comprados)
usort($produtos, function($a, $b) use ($historicoIds) {
    $posA = array_search($a['id'], $historicoIds);
    $posB = array_search($b['id'], $historicoIds);
    return ($posA === false ? PHP_INT_MAX : $posA) - ($posB === false ? PHP_INT_MAX : $posB);
});
?>

<!DOCTYPE html>
<html lang="pt-br">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Loja Online</title>
    <link rel="stylesheet" href="home.css">
</head>
<body>
    <header>
        <div class="header-container">
            <div class="logo">
                <h1>🧺Mercado</h1>
            </div>
            <div class="search-bar">
                <input type="text" id="search-input" placeholder="Buscar produtos...">
            </div>
            <div class="cart-notification">
                <img id="cart-icon" src="img/cart-icon.png" alt="Carrinho">
                <span id="cart-count">0</span>
            </div>
            <div class="header-right">
                <?php if ($userId): ?>
                    <button id="logout-button">Logout</button>
                <?php else: ?>
                    <button id="login-button">Login</button>
                <?php endif; ?>
            </div>
        </div>
    </header>

    <!-- Categorias Dinâmicas -->
    <div class="categories-container">
        <?php foreach ($categorias as $categoria): ?>
            <div class="category" data-id="<?= htmlspecialchars($categoria['id'], ENT_QUOTES, 'UTF-8') ?>">
                <?= htmlspecialchars($categoria['nome'], ENT_QUOTES, 'UTF-8') ?>
            </div>
        <?php endforeach; ?>
    </div>

    <main>
        <div class="product-container" id="product-container">
            <?php foreach ($produtos as $produto): ?>
                <div class="product" data-id="<?= htmlspecialchars($produto['id'], ENT_QUOTES, 'UTF-8') ?>" data-name="<?= htmlspecialchars($produto['nome'], ENT_QUOTES, 'UTF-8') ?>" data-price="<?= htmlspecialchars($produto['preco'], ENT_QUOTES, 'UTF-8') ?>" data-category-id="<?= htmlspecialchars($produto['categoria_id'], ENT_QUOTES, 'UTF-8') ?>">
                    <img src="<?= htmlspecialchars($produto['imagem'], ENT_QUOTES, 'UTF-8') ?>" alt="<?= htmlspecialchars($produto['nome'], ENT_QUOTES, 'UTF-8') ?>">
                    <div class="product-info">
                        <h2><?= htmlspecialchars($produto['nome'], ENT_QUOTES, 'UTF-8') ?></h2>
                        <p class="price">R$ <?= number_format($produto['preco'], 2, ',', '.') ?></p>
                        <div class="product-actions">
                            <button class="add-to-cart" data-id="<?= htmlspecialchars($produto['id'], ENT_QUOTES, 'UTF-8') ?>" data-name="<?= htmlspecialchars($produto['nome'], ENT_QUOTES, 'UTF-8') ?>" data-price="<?= htmlspecialchars($produto['preco'], ENT_QUOTES, 'UTF-8') ?>">Comprar</button>
                            <input type="number" class="quantity" value="1" min="1" max="<?= htmlspecialchars($produto['quantidade_estoque'], ENT_QUOTES, 'UTF-8') ?>" />
                        </div>
                    </div>
                </div>
            <?php endforeach; ?>
        </div>
    </main>
    
    <!-- Popup do carrinho -->
    <div id="cart-sidebar">
        <h2>Seu Carrinho</h2>
        <ul id="cart-items"></ul>
        <div id="cart-total">Total: R$ 0,00</div>
        <button id="checkout-button">Finalizar Compra</button>
        <button id="clear-cart-button">Limpar Carrinho</button>
    </div>
    
    <footer>
        <div class="footer-container">
            <p>&copy; <?= date('Y') ?> Loja Online. Todos os direitos reservados.</p>
        </div>
    </footer>

    <script src="home.js"></script>
</body>
</html>
