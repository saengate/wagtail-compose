[![GitHub tag (latest by date)](https://img.shields.io/github/v/tag/saengate/djfullapp)](https://github.com/saengate/djfullapp/releases/latest)
[![GitHub](https://img.shields.io/github/license/saengate/djfullapp)](LICENSE)
[![GitHub contributors](https://img.shields.io/github/contributors/saengate/djfullapp)](https://github.com/saengate/djfullapp/graphs/contributors)
[![Build Status](https://travis-ci.org/saengate/djfullapp.svg?branch=master)](https://travis-ci.org/saengate/djfullapp)

# DJFULLAPP

### Imagen de Django 2.2.13/VueJs con Nginx (Supervisor-Daphne), PostgreSQL, Neo4j y Apache Airflow.

## Descripción

Crear una imagen de docker con roles ansible que sirve como template para otras aplicaciones.
Al usar ansible se pueden modificar las contraseñas importantes y las configuraciones.
Solo debe tenerse cuidado en los contenedores si se cambian los puertos.

### Dependencias

* [Docker](https://docs.docker.com/engine/install/)
* [Docker-composer](https://docs.docker.com/compose/install/)
* [Ansible](https://docs.ansible.com/ansible/latest/installation_guide/intro_installation.html)
* [poetry](https://pypi.org/project/poetry/)

### ¿Cómo instalar?

Debes tener instalado docker y ansible en tu equipo, se dejan arriba los links para su instalación.
Instalar Ansible sera necesario para modificar las contraseñas encryptadas.

## Desarrollo

Te recomiendo usar alias en tu perfil de usuario para que te sea sencillo usar los scripts que facilita el proyecto
por ejemplo, esto puedes hacerlo buscando en tu $HOME el archivo `.bashrc` o `.zshrc`, entre otros, si no conoces de ellos
busca los archivos que terminan en `rc` dentro del $HOME o investiga un poco al respecto sobre como agregar las variables
de entorno en tu OS.

```sh
export PROJECT="/dir/path/djfullapp"
alias cds="$PROJECT"
alias cmd="$PROJECT/cmd"
alias cmdp="$PROJECT/project/cmd"
alias cmdn="$PROJECT/neo4j/cmd"
alias cmdb="$PROJECT/postgres/cmd"
```

Levantar el proyecto
```sh
docker-compose up --build -d | cmd -db
```

Se agrega el comando "cmd" para facilitar el uso del proyecto y su interacción con docker-compose y vault-ansible:
```sh
./cmd -h | cmd -h
```
```sh
-h | * | --help   muestran los comandos disponibles

-D   | --daemon         inciar el proyecto en background            (docker-compose up -d)
-DB  | --daemon_build   construye e incia el proyecto en background (docker-compose up --build -d)
-d   | --start          inciar el proyecto con verbose              (docker-compose up)
-db  | --start_build    construye e incia el proyecto con verbose   (docker-compose up --build)
-dl  | --docker_list    lista los contenedores por Imagen Estado y  (docker ps)
                        Puestos
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

### Manejo de branch

Uso git `hubflow` para el trabajo con las ramas
Para iniciar el uso de hubflow en el proyecto por primera vez usa `git hf init`
Para crear una nueva rama `git hf `TAG` start nombre-de-la-rama` recuerda que TAG varia dependiendo del objetivo de la rama.
Para actualizar la rama y `develop` con los cambios que esten arriba ejecuta `git hf update`.
Elimina la rama localmente y en github `git hf feature finish nombre-de-la-rama`.

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

## Error

### Supervisor

```sh
unix:///var/run/supervisor.sock no such file
```

En ocasiones necesitaras reiniciar el servicio, y verás este error,  el problema se debe a que hace falta carga 
cada vez las configuraciones de supervisor, el comando es simple pero para simplificar la tarea ejecuta el siguiente
comando que carga las configuraciones y refresta todo el entorno supervisor. (Si quieres conocer los detalles,
revisa el archivo en ansible template dentro del projecto o en /usr/local/bin/runsupervisor)

```sh
runsupervisor
```

## Deploy de una nueva versión.

Para generar una nueva versión, se debe crear un PR (con un título "Release X.Y.Z" con los valores que correspondan para X, Y y Z). Se debe seguir el estándar semver para determinar si se incrementa el valor de X (si hay cambios no retrocompatibles), Y (para mejoras retrocompatibles) o Z (si sólo hubo correcciones a bugs).

En ese PR deben incluirse los siguientes cambios:

Modificar el archivo `CHANGELOG.md` y `VERSION` para incluir una nueva entrada (al comienzo) para X.Y.Z que explique los cambios.
Modificar el archivo `poetry.toml` para que la propiedad `"version"` apunte a la nueva versión X.Y.Z

Luego de obtener aprobación del pull request, debe mezclarse a master e inmediatamente generar un release en GitHub con el tag X.Y.Z. En la descripción del release debes poner lo mismo que agregaste al changelog.
