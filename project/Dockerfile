FROM nginx:stable

# RUN apt-get update
# RUN apt-get install -y software-properties-common gpg-agent
# RUN apt-add-repository --yes --update ppa:ansible/ansible
RUN apt-get update
RUN apt-get install -y python3-pip supervisor python3-venv libpq-dev python3-dev openssh-server openssh-client curl
RUN pip3 install --upgrade pip

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

WORKDIR /tmp

COPY scripts/entrypoint.sh /tmp
COPY ansible /root/ansible
COPY requirements.txt ./
COPY scripts/config.sh ./

# RUN curl https://bootstrap.pypa.io/get-pip.py -o get-pip.py
# RUN python3 get-pip.py --user
RUN pip3 install ansible

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

WORKDIR /tmp

EXPOSE 22 80 5000 5555

ENTRYPOINT ["bash", "entrypoint.sh"]
