FROM debian:stable

RUN apt-get update
RUN apt-get install -y sudo python3-pip python3-apt python3-dev python3-psycopg2
RUN apt-get install -y openssh-server openssh-client curl nano
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

COPY ansible /root/ansible
COPY ./scripts/entrypoint.sh /opt/scripts/

EXPOSE 5432 22

WORKDIR /opt/scripts
ENTRYPOINT ["bash", "entrypoint.sh"]