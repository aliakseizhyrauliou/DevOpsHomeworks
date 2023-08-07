#!/bin/bash

sudo yum update

sudo yum install -y epel-release
sudo yum install -y ca-certificates curl gnupg

sudo yum install -y yum-utils device-mapper-persistent-data lvm2
sudo yum-config-manager --add-repo https://download.docker.com/linux/centos/docker-ce.repo
sudo yum install -y docker-ce docker-ce-cli containerd.io

sudo systemctl start docker
sudo systemctl enable docker

sudo usermod -aG docker $(whoami)

# Установка Git
sudo yum install -y git

echo "Установка Docker и Git завершена."
