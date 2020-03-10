FROM nginx:latest

RUN apt-get update
RUN apt-get install -y python3-pip supervisor python3-venv libpq-dev python3-dev
RUN pip3 install --upgrade pip

WORKDIR /tmp

COPY project/requirements.txt ./
COPY scripts/config.sh ./

RUN mkdir -p /webapps
RUN bash config.sh

ENV AIRFLOW_HOME=/usr/local/airflow
COPY ./airflow/airflow.cfg /usr/local/airflow/airflow.cfg
RUN mkdir -p /var/log/airflow

ENV log=/var/log/project
ENV project=/var/www/project

RUN mkdir -p $log
RUN touch $log/console.log
RUN mkdir -p $project/conf

WORKDIR $project

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
RUN chmod +x /usr/local/bin/*

RUN ln -s /var/www/project/airflow/dags /usr/local/airflow/

EXPOSE 80 5000 5555

CMD ["/bin/bash"]