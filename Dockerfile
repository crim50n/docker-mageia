FROM mageia:latest

RUN (urpmi.addmedia --distrib --mirrorlist '$MIRRORLIST'; \
     urpmi --auto --auto-update; \
     urpmi --auto passwd openssh-server openssh screen zip unzip mc htop bash-completion git draklive; \
     rpm -e cracklib-dicts --nodeps; \
     urpmi --auto cracklib-dicts; \
     urpmi.removemedia -a; \
     mkdir /build; \
     cd /build; \
     git clone git://git.mageia.org/software/build-system/draklive/; \
     git clone git://git.mageia.org/software/build-system/draklive-config/)
     
RUN (sed -i 's/#PasswordAuthentication yes/PasswordAuthentication yes/g' /etc/ssh/sshd_config; \
     sed -i 's/#PermitRootLogin prohibit-password/PermitRootLogin yes/' /etc/ssh/sshd_config; \
     echo "root:password" | chpasswd; \
     usr/bin/ssh-keygen -A)

EXPOSE 22

CMD /usr/sbin/sshd -D
