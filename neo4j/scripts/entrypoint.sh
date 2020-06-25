#!/bin/bash
service ssh start

ssh-keyscan -H localhost >> ~/.ssh/known_hosts
cd ~/ansible
ansible-playbook config-neo4j.yml

/bin/bash
