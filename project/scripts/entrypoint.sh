#!/bin/bash
# service ssh start

# ssh-keyscan -H localhost >> ~/.ssh/known_hosts
# cd /tmp/ansible
# ansible-playbook config-project.yml

# Resuelve el problema "supervisor.sock permiso denegado"
supervisord -c /etc/supervisord.conf

supervisorctl reread
supervisorctl update

supervisorctl start all

service supervisor start
service nginx start
cd /webapps/project
/bin/bash
