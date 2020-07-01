[![GitHub tag (latest by date)](https://img.shields.io/github/v/tag/saengate/djfullapp)](https://github.com/saengate/djfullapp/releases/latest)
[![GitHub](https://img.shields.io/github/license/saengate/djfullapp)](LICENSE)
[![GitHub contributors](https://img.shields.io/github/contributors/saengate/djfullapp)](https://github.com/saengate/djfullapp/graphs/contributors)
[![Build Status](https://travis-ci.org/saengate/djfullapp.svg?branch=master)](https://travis-ci.org/saengate/djfullapp)

# Django - Postgresql-11 - Nginx

Imagen de Django 2.2.13/VueJs con Nginx, PostgreSQL, Neo4j y Apache Airflow.

## Descripción

Crear una imagen de docker con roles ansible que sirve como template para otras aplicaciones.
Al usar ansible se pueden modificar las contraseñas importantes y las configuraciones.
Solo debe tenerse cuidado en los contenedores si se cambian los puertos.

Se agrega el comando "cmd" para facilitar el uso del proyecto y su interacción con docker-compose y vault-ansible:
```sh
./cmd -h
```
```sh
-h | * | --help   muestran los comandos disponibles

-D   | --daemon         inciar el proyecto en background            (docker-compose up -d)
-DB  | --daemon_build   construye e incia el proyecto en background (docker-compose up --build -d)
-d   | --start          inciar el proyecto con verbose              (docker-compose up)
-db  | --start_build    construye e incia el proyecto con verbose   (docker-compose up --build)
-p   | --shell_project  accede al contenedor del proyecto           (docker exec -it)
-tp  | --tests_python   entra al contenedor del proyecto y ejecuta  (docker exec -it.../manage.py test)
                        los tests de Python
INHABILITADA -tn
-tn  | --tests_npm      entra al contenedor de vue y ejecuta        (docker exec -it...npm run test)
                        los tests npm
-pg  | --shell_postgres accede al contenedor de PostgreSQL          (docker exec -it)
-neo | --shell_neo4j    accede al contenedor de Neo4j               (docker exec -it)
-s   | --stop           detiene los contenedores                    (docker-compose down)
```

### Dependencias

* [Docker](https://docs.docker.com/engine/install/)
* [Docker-composer](https://docs.docker.com/compose/install/)
* [Ansible](https://docs.ansible.com/ansible/latest/installation_guide/intro_installation.html)

### ¿Cómo instalar?

Debes tener instalado docker y ansible en tu equipo, se dejan arriba los links para su instalación.
Instalar Ansible sera necesario para modificar las contraseñas encryptadas.

## Desarrollo

```sh
docker-compose up --build -d
```

## Testing

Se pueden ejecutar las pruebas de python usando el comando:
```sh
./cmd -tp | --tests_python
```
Aún están por agregarse las pruebas en vue

## Paso a producción

Aún no esta listo para producción, se deben cambiar manualmente el `hosts: production` en cada archivo del contenedor
de ansible config-(contenedor).yml
```sh
docker-compose -f docker-compose.yml -f docker-compose.prod.yml up --build
```

## Notas

Para validar que los servicios estan arriba al usar docker
```sh
nmap 0.0.0.0 -p 23 | grep -i tcp
nmap 0.0.0.0 -p 24 | grep -i tcp
nmap 0.0.0.0 -p 25 | grep -i tcp
nmap 0.0.0.0 -p 80 | grep -i tcp
nmap 0.0.0.0 -p 5432 | grep -i tcp
nmap 0.0.0.0 -p 5555 | grep -i tcp
nmap 0.0.0.0 -p 7473 | grep -i tcp
nmap 0.0.0.0 -p 7474 | grep -i tcp
nmap 0.0.0.0 -p 7687 | grep -i tcp
nmap 0.0.0.0 -p 8001 | grep -i tcp
```

Cada contenedor contiene una llave para el Vault de ansible, debe ingresar a cada uno y revisar
el archivo .key dentro de la carpeta ansible si desea cambiar las contraseñas.
En la configuración de ansible puede buscar la palabra ".key" y comentar la linea para que no busque
la contraseña en un archivo y así asignar una contraseña nueva y guardarla en algún lugar seguro.
