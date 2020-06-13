# https://hub.docker.com/r/puckel/docker-airflow https://github.com/puckel/docker-airflow
# https://medium.com/@xnuinside/quick-guide-how-to-run-apache-airflow-cluster-in-docker-compose-615eb8abd67a
# https://github.com/xnuinside/airflow_in_docker_compose
FROM puckel/docker-airflow:1.10.6
RUN pip install --user psycopg2-binary
ENV AIRFLOW_HOME=/usr/local/airflow
COPY ./airflow.cfg /usr/local/airflow/airflow.cfg