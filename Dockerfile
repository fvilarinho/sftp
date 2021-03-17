FROM ghcr.io/concepting-com-br/base-image:latest

LABEL maintainer="fvilarinho@concepting.com.br"

ENV SETTINGS_HOSTNAME=host.docker.internal
ENV SETTINGS_PORT=2379
ENV SETTINGS_URL=http://${SETTINGS_HOSTNAME}:${SETTINGS_PORT}

USER root

RUN apk update && \
    apk --no-cache add openssh-sftp-server \
                       openssh-server && \
    apk --no-cache \ 
        --repository=http://dl-cdn.alpinelinux.org/alpine/edge/testing \ 
        add etcd-ctl
                       
RUN /usr/bin/ssh-keygen -A

COPY bin/startup.sh ${BIN_DIR}/child-startup.sh
COPY bin/install.sh ${BIN_DIR}/child-install.sh
COPY .env ${ETC_DIR}/

RUN chmod +x ${BIN_DIR}/child-*.sh && \
    chown -R user:group ${HOME_DIR}/
    chmod -R o-rwx ${HOME_DIR}/

CMD ["${BIN_DIR}/child-startup.sh"]
