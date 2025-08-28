FROM ghcr.io/fvilarinho/base-image:1.2.0

LABEL maintainer="fvilarinho@gmail.com"

USER root

RUN apk update && \
    apk --no-cache add openssh-sftp-server \
                       openssh-server \
                       rsync

RUN /usr/bin/ssh-keygen -A

COPY bin/startup.sh ${BIN_DIR}/child-startup.sh
COPY bin/install.sh ${BIN_DIR}/child-install.sh
COPY .env ${ETC_DIR}/.release

RUN chmod +x ${BIN_DIR}/child-*.sh && \
    chown -R user:group ${HOME_DIR}/ && \
    chmod -R o-rwx ${HOME_DIR}/

CMD ["${BIN_DIR}/child-startup.sh"]
