# Docker interactivo para crear la aplicación Vue
FROM debian:stable

RUN apt-get update
RUN apt-get install -y sudo nano curl 
RUN sudo curl -sL https://deb.nodesource.com/setup_14.x | bash -
RUN apt-get update
RUN apt-get install -y nodejs

WORKDIR /app
RUN npm install -g @vue/cli

ENTRYPOINT ["/bin/bash"]
