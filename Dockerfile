FROM mageia:latest

MAINTAINER Dmitry Svetly  "crims0n@ya.ru"

RUN urpmi.addmedia --distrib --mirrorlist '$MIRRORLIST'

RUN urpmi --auto --auto-update 

RUN urpmi --auto passwd openssh-server openssh screen zip unzip mc htop bash-completion


RUN (sed -i 's/#PasswordAuthentication yes/PasswordAuthentication yes/g' /etc/ssh/sshd_config; \
     sed -i 's/#PermitRootLogin prohibit-password/PermitRootLogin yes/' /etc/ssh/sshd_config)

RUN rpm -e cracklib-dicts --nodeps; urpmi --auto cracklib-dicts; echo "root:password" | chpasswd; /usr/bin/ssh-keygen -A



EXPOSE 22

CMD /usr/sbin/sshd -D
