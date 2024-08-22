<?php

namespace Controllers;

use Models\Product;

/**
 * Classe ProductController
 *
 * Controlador responsável pelas ações relacionadas aos produtos.
 */
class ProductController
{
    /**
     * Listar todos os produtos
     *
     * Recupera todos os produtos da base de dados e os retorna como JSON.
     */
    public function index()
    {
        $products = Product::all();
        echo json_encode($products);
    }

    /**
     * Mostrar um produto específico
     *
     * @param int $id O ID do produto
     */
    public function show(int $id)
    {
        $product = Product::find($id);
        if ($product) {
            echo json_encode($product);
        } else {
            http_response_code(404);
            echo json_encode(['error' => 'Product not found']);
        }
    }

    /**
     * Criar um novo produto
     *
     * Recebe dados do cliente e cria um novo produto na base de dados.
     */
    public function create()
    {
        $data = json_decode(file_get_contents('php://input'), true);
        $product = Product::create($data);
        echo json_encode($product);
    }

    /**
     * Atualizar um produto existente
     *
     * @param int $id O ID do produto a ser atualizado
     */
    public function update(int $id)
    {
        $data = json_decode(file_get_contents('php://input'), true);
        $product = Product::update($id, $data);
        if ($product) {
            echo json_encode($product);
        } else {
            http_response_code(404);
            echo json_encode(['error' => 'Product not found']);
        }
    }

    /**
     * Excluir um produto
     *
     * @param int $id O ID do produto a ser excluído
     */
    public function delete(int $id)
    {
        $deleted = Product::delete($id);
        if ($deleted) {
            echo json_encode(['message' => 'Product deleted']);
        } else {
            http_response_code(404);
            echo json_encode(['error' => 'Product not found']);
        }
    }
}
