FROM mageia:latest

MAINTAINER Dmitry Svetly  "crims0n@ya.ru"

RUN urpmi --auto --auto-update 

RUN urpmi --auto passwd openssh screen zip unzip mc htop bash-completion

RUN (systemctl start sshd; \
     sed -i 's/#PasswordAuthentication no/PasswordAuthentication yes/g' /etc/ssh/sshd_config; \
     sed -i 's/#PermitRootLogin yes/PermitRootLogin yes/' /etc/ssh/sshd_config)

RUN echo "root:password" | chpasswd

EXPOSE 22

CMD /usr/sbin/sshd -D
