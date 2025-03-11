#Download base image ubuntu 18.04
FROM ubuntu:18.04

RUN apt-get update
RUN apt-get -y install python3 python3-nacl python3-pip libffi-dev

# Install ansible
RUN pip3 install ansible

# Copy your ansible configuration into the image
COPY ansible /ansible
COPY ./terraform /terraform

# Run ansible to configure things
RUN chmod -R 777 /terraform/bootstrap.sh

RUN apt-get -y install wget
RUN apt-get -y install sudo
RUN wget -qO - https://as-repository.openvpn.net/as-repo-public.gpg | apt-key add -
RUN echo "deb http://as-repository.openvpn.net/as/debian bionic main">/etc/apt/sources.list.d/openvpn-as-repo.list
RUN apt update && apt -y install openvpn-as
RUN apt-get -y install systemd 

#RUN useradd -m docker && echo "docker:docker" | chpasswd && adduser docker sudo
#USER docker
#RUN /terraform/bootstrap.sh
#RUN ansible-playbook /ansible//minecraft-server-playbook.yml

