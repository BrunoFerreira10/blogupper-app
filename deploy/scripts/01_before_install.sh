#!/bin/bash

echo "------ Parar aplicação ------"
systemctl stop apache2
sudo a2enmod rewrite


