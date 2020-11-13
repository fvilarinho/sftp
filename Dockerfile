FROM alpine:latest

MAINTAINER Felipe Vilarinho <fvilarinho@innovativethinking.com.br>

ENV DEFAULT_USERNAME=sftp
ENV DEFAULT_PASSWORD=Sftp@2017
ENV DEFAULT_PORT=22

RUN apk update && \
    apk --no-cache add vim ca-certificates tar bash bash-completion tzdata unzip curl wget bind-tools net-tools openssh-client openssh-sftp-server openssh-server && \
    cp /usr/share/zoneinfo/America/Sao_Paulo /etc/localtime && \
    echo "America/Sao_Paulo" > /etc/timezone && \
    apk del tzdata && \
    /usr/bin/ssh-keygen -A && \
    mkdir -p /opt/sftp

COPY src/configs/sshd_config /etc/ssh/
COPY src/scripts/install.sh /opt/sftp/
COPY src/scripts/startup.sh /opt/sftp/

RUN chmod +x /opt/sftp/*
    
ENTRYPOINT ["/opt/sftp/startup.sh"]