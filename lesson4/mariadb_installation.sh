#!/bin/bash

sudo apt update

sudo apt install -y mariadb-server

sudo systemctl start mariadb

sudo systemctl enable mariadb

sudo mysql_secure_installation

echo systemctl status mariadb

echo "MariaDB installed successfully."