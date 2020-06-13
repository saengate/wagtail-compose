#!/bin/bash
service ssh start

ssh-keyscan -H localhost >> ~/.ssh/known_hosts
cd ~/ansible
ansible-playbook config-project.yml

# Resuelve el problema "supervisor.sock permiso denegado"
echo_supervisord_conf > /etc/supervisord.conf
supervisord -c /etc/supervisord.conf

supervisorctl reread
supervisorctl update
supervisorctl start all

service supervisor start
service nginx start

cd /var/www/project
/bin/bash
