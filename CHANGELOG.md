# Changelog
Todos los cambios notables a este proyecto serán documentados en este archivo.

El formato está basado en [Keep a Changelog](http://keepachangelog.com/en/1.0.0/)
y este proyecto adhiere a [Semantic Versioning](http://semver.org/spec/v2.0.0.html).

## [0.0.0] - YYYY-MM-DD
### Added
### Fixed
### Feature
- [Descripción.](https://github.com/saengate/djfullapp/pull/#)

## [0.5.0] - 2020-07-20
### Feature
- [Agrega como submodulos las carpetas `neo4j`, `postgres`, `vue` y `django`.](https://github.com/saengate/djfullapp/pull/31)

## [0.4.3] - 2020-07-19
### Fixed
- [Mueve ansible del entrypoin al dockerfile para acelerar el inicio del contenedor.](https://github.com/saengate/djfullapp/pull/30)

## [0.4.2] - 2020-07-18
### Fixed
- [Cambia el nombre de los archivos README para subirlo en dockerhub desde travis.](https://github.com/saengate/djfullapp/pull/28)
- [Corrige errores en las configuraciones de nginx.](https://github.com/saengate/djfullapp/pull/28)

## [0.4.1] - 2020-07-16
### Fixed
- [Agrega a travis un script para enviar a dockerhub el readme del proyecto.](https://github.com/saengate/djfullapp/pull/27)

## [0.4.0] - 2020-07-16
### Added
- [Agrega forma de enviar el readme a dockerhub desde travis.](https://github.com/saengate/djfullapp/pull/24)
- [Agrega documentación y ejemplos para crear volumenes persistentes para las bases de datos.](https://github.com/saengate/djfullapp/pull/24)
- [Cambia el nombre de los contenedores para que coincidan con el proyecto.](https://github.com/saengate/djfullapp/pull/24)
### Fixed
- [Corrige la ejecución del wait-for-it y ejecuta las migraciones desde docker-compose.](https://github.com/saengate/djfullapp/pull/24)

## [0.3.0] - 2020-07-07
### Feature
- [Configura el registro de logs con colores y agrega comandos shell para el uso del projecto.](https://github.com/saengate/djfullapp/pull/17)
- [Agrega `Poetry` como manejador de paquetes en remplazo del `requirements.txt`.](https://github.com/saengate/djfullapp/pull/18)
- [Agrega `django-easy-audit` como manejador de auditoria del proyecto.](https://github.com/saengate/djfullapp/pull/19)
- [Agrega a `Vue.js` los test `Jest`, commandos para su ejecución, mejora el modo producción.](https://github.com/saengate/djfullapp/pull/20)
- [Agrega a `Vue.js` y al proyecto `django` soporte de internacionalización.](https://github.com/saengate/djfullapp/pull/21)

## [0.2.0] - 2020-07-01
### Feature
- [Fusionar y ajustar variables y parametros de ansible que sean delicados en los distintos ambientes.](https://github.com/saengate/djfullapp/pull/14)
- [Crear shell script con comando para facilitar el uso del proyecto, docker y vault-ansible.](https://github.com/saengate/djfullapp/pull/15)

## [0.1.0] - 2020-06-28
### Feature
- Se agrega roles de ansible a la instalción, se realizan varias integraciones para llegar esta beta.
- Se agrega postgresql.
- Se agrega neo4j.
- se agrega vue.