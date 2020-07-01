## Descripción Vue
Fronend de la aplicación

## Desarrollo

```sh
docker build --no-cache -t vue .
docker build --no-cache --target base-develop -t vue .
docker run -p 80:80 --rm -it --name vue vue
```

## Notas

Para validar que los servicios estan arriba al usar docker
```sh
nmap 0.0.0.0 -p 80 | grep -i tcp
```