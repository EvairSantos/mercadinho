#!/bin/bash

# Atualizar o sistema
sudo apt update && sudo apt upgrade -y

# Instalar PHP, MySQL e extensões necessárias
sudo apt install -y php php-cli php-fpm php-mysql php-xml php-mbstring php-curl php-zip mysql-server

# Configurar MySQL (definindo uma senha para o root)
MYSQL_ROOT_PASSWORD="203015#!"
DB_NAME="mercadinho"
DB_USER="root"
DB_PASS="203015#!"

# Atualizar senha do usuário root do MySQL
sudo mysql -e "ALTER USER 'root'@'localhost' IDENTIFIED WITH mysql_native_password BY '${MYSQL_ROOT_PASSWORD}'; FLUSH PRIVILEGES;"

# Criar banco de dados e usuário
sudo mysql -u root -p${MYSQL_ROOT_PASSWORD} -e "CREATE DATABASE IF NOT EXISTS ${DB_NAME};"
sudo mysql -u root -p${MYSQL_ROOT_PASSWORD} -e "CREATE USER '${DB_USER}'@'localhost' IDENTIFIED BY '${DB_PASS}';"
sudo mysql -u root -p${MYSQL_ROOT_PASSWORD} -e "GRANT ALL PRIVILEGES ON ${DB_NAME}.* TO '${DB_USER}'@'localhost';"
sudo mysql -u root -p${MYSQL_ROOT_PASSWORD} -e "FLUSH PRIVILEGES;"

# Clonar o repositório do projeto
git clone https://github.com/EvairSantos/mercadinho.git /var/www/html/mercadinho

# Navegar para o diretório do projeto
cd /var/www/html/mercadinho

# Importar o arquivo SQL para o banco de dados
sudo mysql -u ${DB_USER} -p${DB_PASS} ${DB_NAME} < /var/www/html/mercadinho/mercadinho.sql

# Instalar Composer
curl -sS https://getcomposer.org/installer | php
sudo mv composer.phar /usr/local/bin/composer

# Instalar dependências do Composer
composer install

# Configurar permissões do projeto
sudo chown -R www-data:www-data /var/www/html/mercadinho
sudo chmod -R 755 /var/www/html/mercadinho

# Configurar o PHP-FPM
sudo systemctl restart php7.4-fpm

# Configurar o Nginx para rodar na porta 443 com SSL
sudo bash -c 'cat > /etc/nginx/sites-available/mercadinho <<EOF
server {
    listen 443 ssl;
    server_name saas.techxx.com.br;

    root /var/www/html/mercadinho/public;
    index index.php index.html index.htm;

    ssl_certificate /etc/ssl/certs/techxx.com.br.crt;
    ssl_certificate_key /etc/ssl/private/techxx.com.br.key;

    location / {
        try_files \$uri \$uri/ /index.php?\$query_string;
    }

    location ~ \.php$ {
        include snippets/fastcgi-php.conf;
        fastcgi_pass unix:/var/run/php/php7.4-fpm.sock;
        fastcgi_param SCRIPT_FILENAME \$document_root\$fastcgi_script_name;
        include fastcgi_params;
    }

    location ~ /\.ht {
        deny all;
    }
}
EOF'

# Ativar a configuração do site e reiniciar o Nginx
sudo ln -s /etc/nginx/sites-available/mercadinho /etc/nginx/sites-enabled/
sudo systemctl restart nginx

echo "Setup concluído com sucesso!"
