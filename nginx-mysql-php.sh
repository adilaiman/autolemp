#!/usr/bin/env bash

# Run this script chmod +x nginx-mysql-php.sh && ./nginx-mysql-php.sh

# make sure script is being run as root
[[ $EUID -ne 0 ]] && echo "Please run this script as sudo." && exit 1

# install nginx and allow through firewall
sudo apt install nginx
sudo ufw allow 'Nginx HTTP'

# install mysql and set root password
sudo debconf-set-selections <<< 'mysql-server mysql-server/root_password password MYPASSWORD123'
sudo debconf-set-selections <<< 'mysql-server mysql-server/root_password_again password MYPASSWORD123'
sudo apt install mysql-server
sudo mysql_secure_installation

# install php
sudo apt install php-fpm php-mysql

# config files
sudo less nginxconfig > /etc/nginx/sites-available/default

echo "All done :)."
