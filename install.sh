#!/usr/bin/env bash
#-*- ENCODING: UTF-8 -*-
read -s -p "Enter Your SUDO password: "  password
echo -e "\n"
echo $password | sudo -S sync
echo -e "\n"
sudo apt-get update
sudo apt install docker.io -y
sudo docker run -it --rm --name djangofull saengate/djfullapp