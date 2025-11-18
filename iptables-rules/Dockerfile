ARG BUILD_FROM
FROM $BUILD_FROM

LABEL QGazQ <email@qgazq.net>

# Install requirements for add-on
RUN apk update && apk add --no-cache \
    net-tools \
    iptables \
    && rm -rf /var/cache/apk/*

COPY run.sh /
RUN chmod a+x /run.sh

CMD [ "/run.sh" ]

