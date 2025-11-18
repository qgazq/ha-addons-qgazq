ARG BUILD_FROM
FROM $BUILD_FROM

LABEL QGazQ <email@qgazq.net>

# Set shell
#SHELL ["/bin/bash", "-o", "pipefail", "-c"]

#ENV LANG C.UTF-8

# Install requirements for add-on
RUN apk update && apk add --no-cache    \
    net-tools                \
    sudo busybox-extras                 \
    hostapd networkmanager-cli iptables \
    &&         \
    rm -rf /var/cache/apk/*

COPY run.sh /
RUN chmod a+x /run.sh

CMD [ "/run.sh" ]
