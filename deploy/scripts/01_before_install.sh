#!/bin/bash

echo "------ Parar aplicação ------"
systemctl stop apache2

rm -rf /var/www/html/index.html

sudo a2enmod rewrite
# sudo a2enmod ssl # Usando via ACM no ELB
sudo a2enmod headers
sudo a2enmod expires
sudo a2enmod deflate
sudo a2enmod mime
sudo a2enmod dir
sudo a2enmod env
sudo a2enmod filter