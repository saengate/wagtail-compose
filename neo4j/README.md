## Descripción

La documentación oficial sobre el rol que instala postgres se encuentra en:
https://galaxy.ansible.com/anxs/postgresql


## Notas

Para cambiar la clave del vault en Ansible (debe estar parado en esta directorio)
```sh
ansible-vault encrypt ansible/group_vars/develop/vault.yml
ansible-vault decrypt ansible/group_vars/develop/vault.yml
ansible-vault rekey ansible/group_vars/develop/vault.yml
ansible-vault view ansible/group_vars/develop/vault.yml
```

Para validar que los servicios estan arriba al usar docker-compose
```sh
nmap 0.0.0.0 -p 7474 | grep -i tcp
nmap 0.0.0.0 -p 7473 | grep -i tcp
nmap 0.0.0.0 -p 7687 | grep -i tcp
```

## Desarrollo

Comprobar que el docker esta levantando, aunque no podrá hacer conexión desde el anfitrión.
```sh
docker build -t  neo4j .
docker run --rm -it --name neo4j neo4j
docker run -v $(pwd)/ansible:/root/ansible --rm -it --name neo4j neo4j
```

