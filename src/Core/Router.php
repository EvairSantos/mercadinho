<?php

namespace Core;

/**
 * Classe Router
 *
 * Esta classe gerencia as rotas da aplicação e delega as requisições
 * para os métodos apropriados nos controladores.
 */
class Router
{
    protected $routes = [];

    public function __construct()
    {
        $this->routes = require __DIR__ . '/../Config/routes.php';

        // Verifica se o retorno é um array
        if (!is_array($this->routes)) {
            throw new \Exception('O arquivo de rotas deve retornar um array.');
        }
    }

    public function run()
    {
        $url = $this->getUrl();

        foreach ($this->routes as $route => $action) {
            $pattern = "#^{$route}$#";
            if (preg_match($pattern, $url, $matches)) {
                [$controller, $method] = explode('@', $action);
                $this->callAction($controller, $method, array_slice($matches, 1));
                return;
            }
        }

        http_response_code(404);
        echo json_encode(['error' => 'Route not found']);
    }

    protected function getUrl(): string
    {
        return parse_url($_SERVER['REQUEST_URI'], PHP_URL_PATH);
    }

    protected function callAction(string $controller, string $method, array $params = [])
    {
        $controllerClass = "\\Controllers\\{$controller}";

        if (!class_exists($controllerClass)) {
            http_response_code(500);
            echo json_encode(['error' => 'Controller class not found']);
            return;
        }

        $instance = new $controllerClass();

        if (!method_exists($instance, $method)) {
            http_response_code(500);
            echo json_encode(['error' => 'Method not found']);
            return;
        }

        call_user_func_array([$instance, $method], $params);
    }
}
