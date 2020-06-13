service ssh start
ssh-keyscan -H localhost >> ~/.ssh/known_hosts
cd ~/ansible
ansible-playbook config-project.yml
/bin/bash
