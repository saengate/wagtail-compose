#!/bin/bash

# Create user userapps and group webapps
groupadd --system webapps
useradd --system --gid webapps --shell /bin/bash --home /webapps/projects userapps

chown userapps /webapps/

pip3 install virtualenv
virtualenv -p python3 /opt/venv
python3 -m venv /opt/venv
source /opt/venv/bin/activate
pip3 install --no-cache-dir -r requirements.txt
