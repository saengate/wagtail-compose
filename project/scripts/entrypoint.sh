#!/bin/bash
# Resuelve el problema "supervisor.sock permiso denegado"
supervisord -c /etc/supervisord.conf

supervisorctl reread
supervisorctl update

supervisorctl start all

service ssh start
service supervisor start
service nginx start
cd /webapps/project
/bin/bash
