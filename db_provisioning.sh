#!/bin/bash
apt-get update -y
apt-get upgrade -y

# MySQL
apt-get install -y mysql-server

# Creazione di un utente non root
mysql -e "CREATE USER 'user1'@'%' IDENTIFIED BY 'Password&1';"
mysql -e "GRANT ALL PRIVILEGES ON *.* TO 'user1'@'%';"

# Creazione database, tabelle e inserimento dati
mysql -e "CREATE DATABASE library_db;"
mysql -e "CREATE TABLE library_db.authors(id INT PRIMARY KEY AUTO_INCREMENT, name VARCHAR(50) NOT NULL, birth_year INT);"
mysql -e "CREATE TABLE library_db.books(id INT PRIMARY KEY AUTO_INCREMENT, title VARCHAR(100) NOT NULL, author_id INT, FOREIGN KEY (author_id) REFERENCES library_db.authors(id));"
mysql -e "INSERT INTO library_db.authors(name, birth_year) VALUES('J.K. Rowling', 1965), ('George Orwell', 1903), ('J.R.R. Tolkien', 1892);"
mysql -e "INSERT INTO library_db.books(title, author_id) VALUES('Harry Potter and the Philosopher''s Stone', 1), ('1984', 2), ('The Hobbit', 3);"

# Configurazione del bind address
sed -i 's/127.0.0.1/0.0.0.0/' /etc/mysql/mysql.conf.d/mysqld.cnf
systemctl restart mysql
