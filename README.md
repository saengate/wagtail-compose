[![GitHub tag (latest by date)](https://img.shields.io/github/v/tag/saengate/djfullapp)](https://github.com/saengate/djfullapp/releases/latest)
[![GitHub](https://img.shields.io/github/license/saengate/djfullapp)](LICENSE)
[![GitHub contributors](https://img.shields.io/github/contributors/saengate/djfullapp)](https://github.com/saengate/djfullapp/graphs/contributors)
[![Build Status](https://travis-ci.org/saengate/djfullapp.svg?branch=master)](https://travis-ci.org/saengate/djfullapp)

# Django - Postgresql-11 - Nginx

Imagen de Django 2.2.10/VueJs con Nginx (Pensado para Ubuntu/Debian).

## Descripción

Crear una imagen de docker con django - nginx incluyendo aplicaciones y librerias de uso común con ejemplos.

### ¿Cómo instalar?

El archivo install.sh realiza la instalación básica de `docker` y ejecuta las lineas para llamar al contenedor.
Instalar Ansible sera necesario para modificar las contraseñas encryptadas.

```bash
docker-compose up --build -d
```

## Testing


## Requisitos


## Dependencias
* Docker (Se instala con install.sh)
* Docker-composer (Se instala con install.sh)
* [Ansible](https://docs.ansible.com/ansible/latest/installation_guide/intro_installation.html)

## Notas

Para cambiar la clave del vault en Ansible
```sh
ansible-vault encrypt ansible/group_vars/develop/vault.yml
ansible-vault decrypt ansible/group_vars/develop/vault.yml
ansible-vault rekey ansible/group_vars/develop/vault.yml
ansible-vault view ansible/group_vars/develop/vault.yml
```

## Desarrollo


## Paso a producción
