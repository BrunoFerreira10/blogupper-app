#!/bin/bash

echo "------ Configurar wp-config ------"

# Mover arquivo sample para wp-config.php
mv /var/www/html/wp-config-sample.php /var/www/html/wp-config.php

# Caminho para o arquivo wp-config.php
CONFIG_FILE="/var/www/html/wp-config.php"

# Valores que você deseja definir
DB_NAME=$(aws ssm get-parameter --name '/github_vars/rds_1_db_name' --with-decryption --query 'Parameter.Value' --output text)
echo "DB_NAME: $DB_NAME"
DB_USER=$(aws ssm get-parameter --name '/github_vars/rds_1_db_username' --with-decryption --query 'Parameter.Value' --output text)
echo "DB_USER: $DB_USER"
DB_PASSWORD=$(aws ssm get-parameter --name '/github_secrets/rds_1_db_password' --with-decryption --query 'Parameter.Value' --output text)
echo "DB_PASSWORD: $DB_PASSWORD"
DB_HOST=$(aws ssm get-parameter --name '/app_vars/rds_1_db_host' --with-decryption --query 'Parameter.Value' --output text)

echo "DB_HOST: $DB_HOST"

# Substituir os valores no arquivo wp-config.php
sed -i "s/define( 'DB_NAME', '.*' );/define( 'DB_NAME', '$DB_NAME' );/" $CONFIG_FILE
sed -i "s/define( 'DB_USER', '.*' );/define( 'DB_USER', '$DB_USER' );/" $CONFIG_FILE
sed -i "s/define( 'DB_PASSWORD', '.*' );/define( 'DB_PASSWORD', '$DB_PASSWORD' );/" $CONFIG_FILE
sed -i "s/define( 'DB_HOST', '.*' );/define( 'DB_HOST', '$DB_HOST' );/" $CONFIG_FILE

echo "------ Ajustar permissões ------"
sudo chown -R www-data:www-data /var/www/html
sudo chmod -R 755 /var/www/html/wp-content
sudo chmod 600 /var/www/html/wp-config.php

echo "------ Finalizado after_install.sh ------"


