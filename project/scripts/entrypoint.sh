#!/bin/bash
service supervisor start

supervisorctl reread
supervisorctl update
supervisorctl start all

service ssh start
service nginx start
/bin/bash
