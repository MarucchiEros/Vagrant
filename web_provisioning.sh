#!/bin/bash
apt-get update -y
apt-get upgrade -y

# Installazione di Apache e php
apt-get install -y apache2
apt-get install -y php libapache2-mod-php php-mysql

# Adminer
mkdir -p /var/www/html/adminer
wget "https://www.adminer.org/latest.php" -O /var/www/html/adminer/index.php --no-check-certificate

# Riavvio di Apache
systemctl restart apache2
