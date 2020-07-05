#!/bin/bash
#-*- ENCODING: UTF-8 -*-

# Num  Colour    #define         R G B
# 0    black     COLOR_BLACK     0,0,0
# 1    red       COLOR_RED       1,0,0
# 2    green     COLOR_GREEN     0,1,0
# 3    yellow    COLOR_YELLOW    1,1,0
# 4    blue      COLOR_BLUE      0,0,1
# 5    magenta   COLOR_MAGENTA   1,0,1
# 6    cyan      COLOR_CYAN      0,1,1
# 7    white     COLOR_WHITE     1,1,1

NC=`tput sgr0`
GREEN=`tput setaf 2`
CYAN=`tput setaf 6`

help()
{
    echo "${CYAN}
    Ayuda: Comandos de ayuda para facilitar el uso del proyecto:

    -h | * | --help   muestran los comandos disponibles

    -D   | --daemon             inciar el proyecto en background            (docker-compose up -d)
    -DB  | --daemon_build       construye e incia el proyecto en background (docker-compose up --build -d)
    -d   | --start              inciar el proyecto con verbose              (docker-compose up)
    -db  | --start_build        construye e incia el proyecto con verbose   (docker-compose up --build)
    -dl  | --docker_list        lista los contenedores por Imagen Estado y  (docker ps)
                                Puestos
    -p   | --shell_project      accede al contenedor del proyecto           (docker exec -it)
    -pt  | --tests_project      entra al contenedor del proyecto y ejecuta  (docker exec -it.../manage.py test)
                                los tests de Python
    -pm  | --proyect_migrate    ejecuta las migraciones en el proyecto      (docker exec -it...django-migrate)

    INHABILITADA -tn
    -tn  | --tests_npm          entra al contenedor de vue y ejecuta        (docker exec -it...npm run test)
                                los tests npm
    -pg  | --shell_postgres     accede al contenedor de PostgreSQL          (docker exec -it)
    -neo | --shell_neo4j        accede al contenedor de Neo4j               (docker exec -it)
    -s   | --stop               detiene los contenedores                    (docker-compose down)
    ${NC}
    "
}


daemon()
{
    echo "${GREEN}Iniciando proyecto como demonio${NC}";
    docker-compose up -d --remove-orphans;
}

daemon_build()
{
    echo "${GREEN}Contruir e iniciar proyecto como demonio${NC}";
    docker-compose up --build -d --remove-orphans;
}

start()
{
    echo "${GREEN}Iniciando proyecto con detalle de logs (verbose mode)${NC}";
    docker-compose up --remove-orphans;
}

start_build()
{
    echo "${GREEN}Contruir e iniciar proyecto con detalle de logs (verbose mode)${NC}";
    docker-compose up --build --remove-orphans;
}

docker_list()
{
    echo "${GREEN}Lista los contenedores por Imagen Estado y Puestos${NC}";
    docker ps --format "table {{.Names}}\t{{.ID}}\t{{.Status}}\t{{.Ports}}";
}

shell_project()
{
    echo "${GREEN}Ingresando al contendedor del proyecto${NC}";
    docker exec -it djangofull /bin/bash;
}

tests_project()
{
    echo "${GREEN}Ejecutando los tests PYTHON del proyecto${NC}";
    docker exec -it djangofull /bin/bash -c "source /opt/venv/bin/activate && ./manage.py test";
}

proyect_migrate()
{
    echo "${GREEN}Ejecutando las migraciones DJANGO ${NC}";
    echo "${RED}Recuerde que debe tener la base de datos funcionando ${NC}";
    docker exec -it djangofull /bin/bash -c "django-migrate";
}

# Comentado hasta que se agregue la ejecución de tests en Vue
# una vez hecho se debe ajustar el comando para ejecutar los test
# tests_npm()
# {
#     echo "${GREEN}Ejecutando los tests NPM VUE del proyecto ${NC}";
#     docker exec -it djangofull-vue npm run test;
# }

shell_postgres()
{
    echo "${GREEN}Ingresando al contendedor de postgres${NC}";
    docker exec -it djangofull-db /bin/bash;
}

shell_neo4j()
{
    echo "${GREEN}Ingresando al contendedor de neo4j${NC}";
    docker exec -it djangofull-neo4j /bin/bash;
}

stop()
{
    echo "${GREEN}Deteniendo proyecto${NC}";
    docker-compose down;
}

if [ "$1" == "" ]; then
    help
    exit 1
fi

while [ "$1" != "" ]; do    
    case $1 in  
        -D   | --daemon )           daemon
                                    exit
                                    ;;
        -DB  | --daemon_build )     daemon_build
                                    exit
                                    ;;
        -d   | --start )            start
                                    exit
                                    ;;
        -db  | --start_build )      start_build
                                    exit
                                    ;;
        -p   | --shell_project )    shell_project
                                    exit
                                    ;;
        -pt  | --tests_project )    tests_project
                                    exit
                                    ;;
        -pm  | --proyect_migrate )  proyect_migrate
                                    exit
                                    ;;
        -dl  | --docker_list )      docker_list
                                    exit
                                    ;;
#         -tn  | --tests_npm )        tests_npm
#                                     exit
#                                     ;;
        -pg  | --shell_postgres )   shell_postgres
                                    exit
                                    ;;
        -neo | --shell_neo4j )      shell_neo4j
                                    exit
                                    ;;
        -s   | --stop )             stop
                                    exit
                                    ;;
        -h   | --help )             help
                                    exit
                                    ;;
        * )                         help
                                    exit 1
    esac
    shift
done

