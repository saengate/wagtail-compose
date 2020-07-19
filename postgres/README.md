## Descripción PostgreSQL

La documentación oficial sobre el rol que instala postgres se encuentra en:
https://galaxy.ansible.com/anxs/postgresql

## Desarrollo

Puede ejecutar  para facilitar el uso del proyecto:
Para ejecutar el comando debe estar dentro de la carpeta contenedora de cada contanedor.
```sh
./cmdb -h | cmdb -h
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
docker build -t postgres .
docker run --rm -it --name -p 5432:5432 -p 24:22 postgres postgres
docker run -v $(pwd)/ansible:/root/ansible -p 5432:5432 -p 24:22 --rm -it --name postgres postgres
```

Para validar que los servicios estan arriba al usar docker
```sh
nmap 0.0.0.0 -p 5432 | grep -i tcp
nmap 0.0.0.0 -p 24 | grep -i tcp
```

Para cambiar la clave del vault en Ansible (debe estar parado en esta directorio)
```sh
ansible-vault encrypt ansible/group_vars/develop/vault.yml
ansible-vault decrypt ansible/group_vars/develop/vault.yml
ansible-vault rekey ansible/group_vars/develop/vault.yml
ansible-vault view ansible/group_vars/develop/vault.yml
```