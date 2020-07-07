## Descripción Neo4j

La documentación sobre el rol que instala neo4j se encuentra en:
Kevin Coakley (https://github.com/kevincoakley)
### Importante
El rol ha sido modificado pero partio desde ese repositorio.

## Desarrollo

Puede ejecutar  para facilitar el uso del proyecto:
Para ejecutar el comando debe estar dentro de la carpeta contenedora de cada contanedor.
```sh
./cmdn -h | cmdn -h
```
```sh
    -h  | * | --help   muestran los comandos disponibles

    -b  | --build           construye el contenedor                         (docker build)
    -r  | --run             inicia y accede al contenedor                   (docker run -it)
    -rv | --run_v           inicia y accede al contenedor y agrega          (docker exec -it)
                            el volumen para los cambios en ansible
                            tengan efecto inmediato
    
    ## VAULT
    -ve | --vault_encrypt [ dev | qa | prod ]   Encrypta los valores sensibles del ambiente     (ansible-vault encrypt)
                                                especificado
    -vd | --vault_decrypt [ dev | qa | prod ]   Desencrypta los valores sensibles del ambiente  (ansible-vault decrypt)
                                                especificado
    -vr | --vault_rekey   [ dev | qa | prod ]   Cambia la llave de encryptación del ambiente    (ansible-vault rekey)
                                                especificado
    -vv | --vault_view    [ dev | qa | prod ]   Muestra los valores del ambiente especificado   (ansible-vault view)
```

## Notas

Algunas de los siguientes comandos ya han sido incluidos en el comando "cmd"
Levantar este contenedor especificamente.
```sh
docker build -t neo4j .
docker run --rm -it --name -p 7687:7687 -p 7474:7474 -p 7473:7473 -p 25:22 neo4j neo4j
docker run -v $(pwd)/ansible:/root/ansible -p 7687:7687 -p 7474:7474 -p 7473:7473 -p 25:22 --rm -it --name neo4j neo4j
```

Para validar que los servicios estan arriba al usar docker
```sh
nmap 0.0.0.0 -p 7474 | grep -i tcp
nmap 0.0.0.0 -p 7473 | grep -i tcp
nmap 0.0.0.0 -p 7687 | grep -i tcp
nmap 0.0.0.0 -p 25 | grep -i tcp
```

Para cambiar la clave del vault en Ansible (debe estar parado en esta directorio)
```sh
ansible-vault encrypt ansible/group_vars/develop/vault.yml
ansible-vault decrypt ansible/group_vars/develop/vault.yml
ansible-vault rekey ansible/group_vars/develop/vault.yml
ansible-vault view ansible/group_vars/develop/vault.yml
```
