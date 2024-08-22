<?php

namespace Models;

use Core\Database;

class Product
{
    /**
     * Retorna todos os produtos.
     *
     * @return array|false
     */
    public static function all()
    {
        $db = Database::getInstance()->getConnection();
        $query = "SELECT * FROM produtos"; // Nome da tabela
        $statement = $db->query($query); // Use query para obter os resultados
        return $statement->fetchAll(\PDO::FETCH_ASSOC); // Utilize \PDO para referenciar a classe global
    }

    /**
     * Encontra um produto pelo ID.
     *
     * @param int $id
     * @return array|null
     */
    public static function find($id)
    {
        $db = Database::getInstance()->getConnection();
        $query = "SELECT * FROM produtos WHERE id = ?"; // Nome da tabela
        $statement = $db->prepare($query);
        $statement->execute([$id]);
        return $statement->fetch(\PDO::FETCH_ASSOC); // Utilize \PDO para referenciar a classe global
    }

    /**
     * Cria um novo produto.
     *
     * @param array $data
     * @return array
     */
    public static function create(array $data)
    {
        $db = Database::getInstance()->getConnection();
        $query = "INSERT INTO produtos (nome, preco, quantidade_estoque, descricao, categoria_id) VALUES (?, ?, ?, ?, ?)"; // Nome da tabela
        $statement = $db->prepare($query);
        $statement->execute([$data['nome'], $data['preco'], $data['quantidade_estoque'], $data['descricao'], $data['categoria_id']]);
        return self::find($db->lastInsertId());
    }

    /**
     * Atualiza um produto existente.
     *
     * @param int $id
     * @param array $data
     * @return array|null
     */
    public static function update($id, array $data)
    {
        $db = Database::getInstance()->getConnection();
        $query = "UPDATE produtos SET nome = ?, preco = ?, quantidade_estoque = ?, descricao = ?, categoria_id = ? WHERE id = ?"; // Nome da tabela
        $statement = $db->prepare($query);
        $statement->execute([$data['nome'], $data['preco'], $data['quantidade_estoque'], $data['descricao'], $data['categoria_id'], $id]);
        return self::find($id);
    }

    /**
     * Deleta um produto.
     *
     * @param int $id
     * @return bool
     */
    public static function delete($id)
    {
        $db = Database::getInstance()->getConnection();
        $query = "DELETE FROM produtos WHERE id = ?"; // Nome da tabela
        $statement = $db->prepare($query);
        return $statement->execute([$id]);
    }
}
