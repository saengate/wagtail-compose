FROM nginx:stable as base-develop

RUN apt-get update
RUN apt-get install -y python3-pip python3-venv python3-dev openssh-server openssh-client
RUN apt-get install -y nano supervisor libpq-dev curl apt-utils
RUN pip3 install --upgrade pip
RUN pip3 install ansible virtualenv

# Install and configure SSH
RUN mkdir /var/run/sshd
RUN sed -i 's/PermitRootLogin prohibit-password/PermitRootLogin yes/' /etc/ssh/sshd_config
# SSH login fix. Otherwise user is kicked off after login
RUN sed 's@session\s*required\s*pam_loginuid.so@session optional pam_loginuid.so@g' -i /etc/pam.d/sshd
ENV NOTVISIBLE "in users profile"
RUN echo "export VISIBLE=now" >> /etc/profile

RUN mkdir -p ~/.ssh
RUN bash -c "ssh-keygen -q -t rsa -N '' -f ~/.ssh/id_rsa 2>/dev/null <<< y >/dev/null"
RUN cat ~/.ssh/id_rsa.pub >> ~/.ssh/authorized_keys
RUN chmod og-wx ~/.ssh/authorized_keys

# Environment Variables
ENV AIRFLOW_HOME=/usr/local/airflow

WORKDIR /tmp

COPY ./ansible ./ansible
COPY ./requirements.txt ./
COPY ./scripts/entrypoint.sh ./
COPY ./ ./project

EXPOSE 22 80 5555 8080

WORKDIR /tmp/ansible
RUN service ssh start && ssh-keyscan -H localhost >> ~/.ssh/known_hosts && ansible-playbook config-project.yml

# Directorio del proyecto, debe modificarse si se cambia el directorio original
# Su cambio provocara un fallo en travis
WORKDIR /webapps/project

ENTRYPOINT ["bash", "/tmp/entrypoint.sh"]
