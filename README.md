[![GitHub tag (latest by date)](https://img.shields.io/github/v/tag/saengate/wagtail-compose)](https://github.com/saengate/wagtail-compose/releases/latest)
[![GitHub](https://img.shields.io/github/license/saengate/wagtail-compose)](LICENSE)
[![GitHub contributors](https://img.shields.io/github/contributors/saengate/wagtail-compose)](https://github.com/saengate/wagtail-compose/graphs/contributors)
[![Build Status](https://travis-ci.org/saengate/wagtail-compose.svg?branch=master)](https://travis-ci.org/saengate/wagtail-compose)

# BLOG (extendido de DJFULLAPP)

## README BLOG
Usa [wagtail](https://wagtail.io/)
https://docs.wagtail.io/en/stable/advanced_topics/add_to_django_project.html

## Descripción

Crear una blog personal usando `wagtail`.


# README Extendido de DJFULLAPP

### Imagen de Django 2.2/Vue CLI v4.4 con Nginx (Supervisor-Daphne), PostgreSQL, Neo4j y Apache Airflow.

## Descripción

Crear una imagen de docker con roles ansible que sirve como template para otras aplicaciones.
Al usar ansible se pueden modificar las contraseñas importantes y las configuraciones.
Solo debe tenerse cuidado en los contenedores si se cambian los puertos.

### Dependencias

* [Docker](https://docs.docker.com/engine/install/)
* [Docker-composer](https://docs.docker.com/compose/install/)
* [Ansible](https://docs.ansible.com/ansible/latest/installation_guide/intro_installation.html)

### ¿Cómo instalar?

Debes tener instalado docker y ansible en tu equipo, se dejan arriba los links para su instalación.
Instalar Ansible sera necesario para modificar las contraseñas encryptadas.

En este momento es recomendable descargar directo desde el [repositorio GitHub](https://github.com/saengate/djfullapp), sin embargo dejo documentado las instrucciones para montar las imágenes con docker-compose:

![#f03c15](https://via.placeholder.com/15/f03c15/000000?text=+) **Deja el volumen comentado la primera vez que levantes el proyecto y luego copia el contenido desde el contenedor a tu carpeta de desarrollo**

```sh
docker-compose up --build
docker cp djfullapp:/tmp/django ./django
docker cp djfullapp-vue:/app/djfullapp-vue ./vue
docker cp {contenedor}:{/tmp/ansible} ${PWD}/{nombre-carpeta-destino}  # Que coincida con el volumen de cada contenedor
docker-compose down
```

Descomenta las lineas de volumen para enlazar el contenedor con tu desarrollo y vuelve a levantar los contenedores
```sh
docker-compose up
```

Ejemplo `docker-compose.yml`
```yml
version: '3.7'

services:
  redis:
    image: redis:latest
    container_name: djfullapp-redis

  db:
    image: saengate/djfullapp:postgres
    container_name: djfullapp-db
    restart: always
    tty: true
#    volumes:
#      - postgres:/var/lib/postgresql/11/main
#      - ./postgres/ansible:/tmp/ansible
    ports:
      - 5432:5432

  neo4j:
    image: saengate/djfullapp:neo4j
    container_name: djfullapp-neo4j
    restart: always
    tty: true
#    volumes:
#      - neo4j:/data
#      - ./neo4j/ansible:/tmp/ansible
    ports:
      - 7473:7473
      - 7474:7474
      - 7687:7687

  vue:
    image: saengate/djfullapp:vue
    container_name: djfullapp-vue
    deploy:
      resources:
        limits:
            cpus: '0.50'
            memory: 50M
        reservations:
          cpus: '0.25'
          memory: 20M
#    volumes:
#      - ./vue:/app/vue
#      - /app/node_modules
    ports:
      - 80:80

  web:
    image: saengate/djfullapp:django
    container_name: djfullapp
    restart: always
    tty: true
    depends_on:
      - redis
      - db
      - neo4j
      - vue
    ports:
      - 7000:80
      - 7001:8080
      - 7002:5555
#    volumes:
#      - ./django:/webapps/django
#      - ./django/ansible:/tmp/ansible
    environment:
      - NGINX_HOST=localhost
      - NGINX_PORT=80
    command: wait-for-it db:5432 -- django-migrate

#volumes:
#  postgres:
#    driver: local-persist
#    driver_opts:
#      mountpoint: ${PWD}/data/postgres
#  neo4j:
#    driver: local-persist
#    driver_opts:
#      mountpoint: ${PWD}/data/neo4j
```

#### Data persistente en las Bases de datos (Postgres y Neo4j)

Para lograr esto se propone hacer uso del repositorio [Local Persist Volume Plugin for Docker](https://github.com/MatchbookLab/local-persist)

Para Mas OS debe serguir las siguientes instrucciones:

```sh
docker run -d --rm \
  -v /run/docker/plugins/:/run/docker/plugins/ \
  -v $(pwd)/:/var/lib/docker/plugin-data/ \
  -v $(pwd)/data/:$(pwd)/data/ \
  --name local-persist \
  cwspear/docker-local-persist-volume-plugin
  /bin/bash
```

### Librerias de terceros

[django-easy-audit](https://github.com/soynatan/django-easy-audit) Es una aplicación de auditoria de fácil uso que he incluido en este projecto. De momento, estará en evaluación y si cumple con las espectativas se volverá parte del proyecto. Todas las instrucciones de uso se encuentran en la descripción de dicho proyecto (Realmente parece que no requiere de ninguna interacción en los modelos, así que al ser prácticamente innecesaria la interacción del desarrollador para su ejecución se evita que por olvido no se monitoree algún modelo, simplemente genial).


## Desarrollo

Te recomiendo usar alias en tu perfil de usuario para que te sea sencillo usar los scripts que facilita el proyecto
por ejemplo, esto puedes hacerlo buscando en tu $HOME el archivo `.bashrc` o `.zshrc`, entre otros, si no conoces de ellos
busca los archivos que terminan en `rc` dentro del $HOME o investiga un poco al respecto sobre como agregar las variables
de entorno en tu OS.

```sh
export PROJECT="/dir/path/djfullapp"
alias cds="$PROJECT"
alias cmd="$PROJECT/cmd"
alias cmdp="$PROJECT/django/cmdp"
alias cmdn="$PROJECT/neo4j/cmdn"
alias cmdb="$PROJECT/postgres/cmdb"
alias cmdv="$PROJECT/vue/cmdv"
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

-D   | --daemon             inciar el proyecto en background            (docker-compose up -d)
-DB  | --daemon_build       construye e incia el proyecto en background (docker-compose up --build -d)
-d   | --start              inciar el proyecto con verbose              (docker-compose up)
-db  | --start_build        construye e incia el proyecto con verbose   (docker-compose up --build)
-dl  | --docker_list        lista los contenedores por Nombre, Estado y (docker ps)
                            Puestos

-pm  | --proyect_migrate    ejecuta las migraciones en el proyecto      (docker exec -it...django-migrate)
-ca  | --create-admin       crea el usuario administrador por defecto   (docker exec -it...createsuperuser)
                            de la aplicación

-tp  | --tests_project      entra al contenedor del proyecto y ejecuta  (docker exec -it.../manage.py test)
                            los tests de Python
-tn  | --tests_npm          entra al contenedor de vue y ejecuta        (docker exec -it...npm run test)
                            los tests npm

-sp  | --shell_project      accede al contenedor del proyecto           (docker exec -it)
-sd  | --shell_postgres     accede al contenedor de PostgreSQL          (docker exec -it)
-sn  | --shell_neo4j        accede al contenedor de Neo4j               (docker exec -it)

-s   | --stop               detiene los contenedores                    (docker-compose down)
```

### Librerias (pip requirements.txt y poetry)

Este proyecto no usa directamente requirements para instalar el proyecto, en su lugar usa [poetry](https://pypi.org/project/poetry/) que generara el archivo durante la creación del contenedor y maneja efectivamente las versiones de las librerias. Se usa este metodo para aprovechar las ventajas de poetry y las ventajas de pip y descartar sus falencias. Revisa el archivo `pyproject.toml` para agregar las librerias, usa el siguiente link para entender como agregar la [versión](https://python-poetry.org/docs/dependency-specification/).

### Manejo de branch

Uso git `hubflow` para el trabajo con las ramas
Para iniciar el uso de hubflow en el proyecto por primera vez usa `git hf init`
Para crear una nueva rama `git hf TAG start NOMBRE-DE-LA-RAMA` recuerda que TAG varia dependiendo del objetivo de la rama.
Debes mezclar la rama según su flujo normal `git push origin TAG/NOMBRE-DE-LA-RAMA`.
Para actualizar la rama y `develop` con los cambios que esten arriba ejecuta `git hf update`.
Elimina la rama localmente y en github `git hf feature finish nombre-de-la-rama`.

### Testing

Se pueden ejecutar las pruebas de python usando el comando:
```sh
./cmd -tp | --tests_python
```

Se pueden ejecutar las pruebas de node usando el comando:
```sh
./cmd -tn | --tests_npm
```

### Deploy de una nueva versión.

Para generar una nueva versión, se debe crear un PR (con un título "Release X.Y.Z" con los valores que correspondan para X, Y y Z). Se debe seguir el estándar semver para determinar si se incrementa el valor de X (si hay cambios no retrocompatibles), Y (para mejoras retrocompatibles) o Z (si sólo hubo correcciones a bugs).

En ese PR deben incluirse los siguientes cambios:

Modificar el archivo `CHANGELOG.md` y `VERSION` para incluir una nueva entrada (al comienzo) para X.Y.Z que explique los cambios.
Modificar el archivo `poetry.toml` para que la propiedad `"version"` apunte a la nueva versión X.Y.Z

Luego de obtener aprobación del pull request, debe mezclarse a master e inmediatamente generar un release en GitHub con el tag X.Y.Z. En la descripción del release debes poner lo mismo que agregaste al changelog.


## Paso a producción

Aún no esta listo para producción, se deben cambiar manualmente el `hosts: production` en cada archivo del contenedor
de ansible config-(contenedor).yml

```sh
docker-compose -f docker-compose.yml -f docker-compose.prod.yml up --build
```


## Notas

Para validar que los servicios estan arriba al usar docker
```sh
nmap 0.0.0.0 -p 23,24,25,80,5432,5555,7473,7474,7687,8001 | grep -i tcp
```

Cada contenedor contiene una llave para el Vault de ansible, debe ingresar a cada uno y revisar
el archivo .key dentro de la carpeta ansible si desea cambiar las contraseñas.
En la configuración de ansible puede buscar la palabra ".key" y comentar la linea para que no busque
la contraseña en un archivo y así asignar una contraseña nueva y guardarla en algún lugar seguro.


### Usar y obtener actualziaciones desde la plantilla.

En gitHub crea un repositorio desde el template de `djfullapp`, para poder obtener los cambios que se generen en el template se deben realizar varias acciones que son importantes comprender.

#### Preparar rama para recibir actualizaciones

- Clona `djfullapp` y desde la rama `master` crea una rama con el mismo nombre del nuevo repositorio (por razones practicas) en este caso será `blog`, esta rama no se empujará a `GIT` así que no será visible en el repositorio de `djfullapp`, tu repositorio privado permanece privado.

```sh
git fetch origin
git checkout master
git branch -b blog
```

#### Control de versiones en mi nuevo repositorio

- Se creo un proyecto usando el template, para este ejemplo es `blog` (desde github).
- Además agrego un nuevo repositorio remoto a `djfullapp` que apunta a ese nuevo repositorio.

```sh
git remote add blog https://github.com/saengate/blog.git
```
 
`Nota intermedia`: Aquí se pone interesante, usando las propiedades de git las actualizaciones de `djfullapp` que quiero empujar en `blog` los realizo dentro de esta rama, por lo que esta rama será la branch intermedio de estos proyectos.


- `Ten cuidado aquí`: Y empuja la rama `blog` dentro del nuevo proyecto cambiando origin por blog:

```sh
git push blog blog
```

- En Github asigna esta rama como la rama principal del proyecto, recuerda que debes hacerlo en el settings de ese repositorio github.

#### Actualizar BLOG con los nuevas versiones de DJFULLAPP

Desde el proyecto `djfullapp` los cambios hacia esta nueva rama se empujan con los siguientes comandos:

Ten cuidado con los comandos que ejecutes aquí, un mal paso puede reescribir el repositorio equivocado.
También recuerda que origin apunta a `djfullapp` y `blog`, bueno a `blog`.
- Cambia a la rama intermediaria `git checkout blog`.
- Actualiza rama intermedia con los cambios que hayas realizado `git pull blog blog`.
- Actualiza la rama `master` de `djfullapp`: `git pull origin master`.
- Mezcla los cambios de `djfullapp` en `blog`:
```sh
git checkout blog
git rebase master
git push blog blog
```
Tendrás que lidiar con algunos conflictos, pero no deberían ser demasiados. Tal vez todos asociados a la carpeta `ses`.
No borres la rama intermedia, `blog` para este caso.

#### Enviar README.md a dockerhub

```sh
export DOCKERHUB_USERNAME="usuario";
export DOCKERHUB_PASSWORD="contraseña";
export DOCKERHUB_REPO_PREFIX="usuario_o_prefijo_en_docker_hub";
export DOCKERHUB_REPO_NAME="repositorio";
docker run --rm -v "$(pwd)/:/data/:ro" -e "DOCKERHUB_USERNAME=$DOCKERHUB_USERNAME" -e "DOCKERHUB_PASSWORD=$DOCKERHUB_PASSWORD" -e "DOCKERHUB_REPO_PREFIX=$DOCKERHUB_REPO_PREFIX" -e "DOCKERHUB_REPO_NAME=$DOCKERHUB_REPO_NAME" sheogorath/readme-to-dockerhub;
```

## Errores conocidos

### Supervisor

```sh
unix:///var/run/supervisor.sock no such file
```

En ocasiones necesitaras reiniciar el servicio y verás este error, el problema se debe a que hace falta cargar
`cada vez` las configuraciones de supervisor, el comando es simple pero para simplificar la tarea ejecuta el siguiente
comando que carga las configuraciones y refresta todo el entorno supervisor. (Si quieres conocer los detalles,
revisa el archivo en ansible template o dentro del projecto o en /usr/local/bin/runsupervisor).

```sh
runsupervisor
```
