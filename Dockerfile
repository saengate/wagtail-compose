FROM nginx:latest

RUN apt-get update
RUN apt-get install -y python3-pip supervisor python3-venv
RUN pip3 install --upgrade pip

WORKDIR /tmp

COPY project/requirements.txt ./
COPY scripts/config.sh ./

RUN mkdir -p /webapps
RUN bash config.sh
# RUN pip3 install --no-cache-dir -r requirements.txt

RUN mkdir -p /var/log/project
RUN touch /var/log/project/console.log

RUN mkdir -p /var/www/project/conf

WORKDIR /var/www/project/

COPY conf_server/project_start /usr/local/bin/
COPY conf_server/project_websocket_start /usr/local/bin/
COPY conf_server/project.supervisor.conf /etc/supervisor/conf.d/
COPY conf_server/app.conf /etc/nginx/sites-available/
COPY conf_server/timeout.conf /etc/nginx/conf.d/

RUN mkdir -p /etc/nginx/sites-enabled
RUN ln -s /etc/nginx/sites-available/app.conf /etc/nginx/sites-enabled/
RUN ln -s /etc/nginx/sites-available/app.conf /etc/nginx/conf.d/
RUN rm /etc/nginx/conf.d/default.conf

# LOGS command bin
COPY docker_bin/* /usr/local/bin/

EXPOSE 80

CMD ["/bin/bash"]