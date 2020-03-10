#!/bin/bash

# Resuelve el problema "supervisor.sock permiso denegado"
echo_supervisord_conf > /etc/supervisord.conf
supervisord -c /etc/supervisord.conf

supervisorctl reread
supervisorctl update
supervisorctl start all

service supervisor start
service nginx start

/bin/bash