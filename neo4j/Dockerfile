FROM debian:stable as base-develop

RUN apt-get update
RUN apt-get install -y python3-pip python3-apt openssh-server openssh-client
RUN apt-get install -y sudo curl nano
RUN pip3 install --upgrade pip
RUN pip3 install ansible

# SSH config
RUN mkdir /var/run/sshd
RUN sed -i 's/PermitRootLogin prohibit-password/PermitRootLogin yes/' /etc/ssh/sshd_config
RUN sed 's@session\s*required\s*pam_loginuid.so@session optional pam_loginuid.so@g' -i /etc/pam.d/sshd
ENV NOTVISIBLE "in users profile"
RUN echo "export VISIBLE=now" >> /etc/profile
RUN mkdir -p ~/.ssh
RUN bash -c "ssh-keygen -q -t rsa -N '' -f ~/.ssh/id_rsa 2>/dev/null <<< y >/dev/null"
RUN cat ~/.ssh/id_rsa.pub >> ~/.ssh/authorized_keys
RUN chmod og-wx ~/.ssh/authorized_keys

COPY ./scripts/entrypoint.sh /opt/scripts/

ENV JAVA_HOME=/usr/lib/jvm/java-11-openjdk-amd64
ENV PATH=$PATH:/usr/share/neo4j/bin:/usr/lib/jvm/java-11-openjdk-amd64/bin
ENV NEO4J_HOME=/usr/share/neo4j

WORKDIR /tmp
COPY ./ansible ./ansible
WORKDIR /tmp/ansible
RUN service ssh start && ssh-keyscan -H localhost >> ~/.ssh/known_hosts && ansible-playbook config-neo4j.yml

EXPOSE 7687 7474 7473 22

WORKDIR /opt/scripts
ENTRYPOINT ["bash", "entrypoint.sh"]