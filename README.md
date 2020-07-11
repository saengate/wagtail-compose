[![GitHub tag (latest by date)](https://img.shields.io/github/v/tag/saengate/djfullapp)](https://github.com/saengate/djfullapp/releases/latest)
[![GitHub](https://img.shields.io/github/license/saengate/djfullapp)](LICENSE)
[![GitHub contributors](https://img.shields.io/github/contributors/saengate/djfullapp)](https://github.com/saengate/djfullapp/graphs/contributors)
[![Build Status](https://travis-ci.org/saengate/djfullapp.svg?branch=master)](https://travis-ci.org/saengate/djfullapp)

# DJFULLAPP

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
alias cmdp="$PROJECT/project/cmdp"
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
Aún están por agregarse las pruebas en vue

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


### USar y Obtener actualziaciones desde la plantilla.

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


## Errores conocidos

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
