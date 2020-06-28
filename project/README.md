Para levantar este contenedor especifico ejecuta:

## Notas

Para cambiar la clave del vault en Ansible (debe estar parado en esta directorio)
```sh
ansible-vault encrypt ansible/group_vars/develop/vault.yml
ansible-vault decrypt ansible/group_vars/develop/vault.yml
ansible-vault rekey ansible/group_vars/develop/vault.yml
ansible-vault view ansible/group_vars/develop/vault.yml
```

```sh
docker run -it --rm --name djangofull saengate/djfullapp

docker build -t  djangofull .
```

Enlazar ansible y el proyecto
```sh
docker run -v $(pwd)/ansible:/tmp/ansible -v $(pwd):/webapps/project --rm -it --name djangofull djangofull
```

Enlaza ansible
```sh
docker run -v $(pwd)/ansible:/tmp/ansible --rm -it --name djangofull djangofull
```
