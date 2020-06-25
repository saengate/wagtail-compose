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

## Desarrollo

```sh
docker build -t  postgres .
docker run --rm -it --name postgres postgres
docker run -v $(pwd)/ansible:/root/ansible --rm -it --name postgres postgres
```