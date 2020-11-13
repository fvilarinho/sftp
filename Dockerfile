FROM ghcr.io/concepting-com-br/base-image:1.0.0

LABEL maintainer="fvilarinho@concepting.com.br"

ENV APP_NAME=sftp

ENV SETTINGS_HOSTNAME=host.docker.internal
ENV SETTINGS_PORT=2379
ENV SETTINGS_URL=http://${SETTINGS_HOSTNAME}:${SETTINGS_PORT}

USER root

RUN apk update && \
    apk --no-cache add openssh-sftp-server \
                       openssh-server && \
    apk --no-cache \ 
        --repository=http://dl-cdn.alpinelinux.org/alpine/edge/testing \ 
        add etcd-ctl && \                       
    rm -f /etc/ssh/sshd_config                   
                       
RUN /usr/bin/ssh-keygen -A

COPY etc/* ${ETC_DIR}/
COPY bin/* ${BIN_DIR}/

RUN ln -s ${ETC_DIR}/sshd_config /etc/ssh/sshd_config && \
    ln -s ${BIN_DIR}/startup.sh /entrypoint.sh && \
    chmod +x ${BIN_DIR}/*.sh
    
ENTRYPOINT ["/entrypoint.sh"]