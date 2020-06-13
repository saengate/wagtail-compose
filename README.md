[![GitHub tag (latest by date)](https://img.shields.io/github/v/tag/saengate/djfullapp)](https://github.com/saengate/djfullapp/releases/latest)
[![GitHub](https://img.shields.io/github/license/saengate/djfullapp)](LICENSE)
[![GitHub contributors](https://img.shields.io/github/contributors/saengate/djfullapp)](https://github.com/saengate/djfullapp/graphs/contributors)
[![Build Status](https://travis-ci.org/saengate/djfullapp.svg?branch=master)](https://travis-ci.org/saengate/djfullapp)

# Django - Nginx

Imagen de Django 2.2.10/VueJs con Nginx (Pensado para Ubuntu/Debian).

## Descripción

Crear una imagen de docker con django - nginx incluyendo aplicaciones y librerias de uso común con ejemplos.

### ¿Cómo instalar?

El archivo install.sh realiza la instalación básica de `docker` y ejecuta las lineas para llamar al contenedor.

```bash
bash install.sh
```

Si ya posee docker instalado puede ejecutar la siguiente instrucción:
```bash
sudo docker run -it --rm --name djangofull saengate/djfullapp
```

## Testing


## Requisitos
* OS linux (Ubuntu/Debian)
* Docker (Se instala con install.sh)
* Docker-composer (Se instala con install.sh)

## Dependencias


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
