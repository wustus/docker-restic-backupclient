FROM alpine:3.22.2

RUN \
    # install restic \
    apk add --update --no-cache tini restic bash restic-bash-completion curl && \
    # install python and tools \
    apk add --update --no-cache tzdata python3 py3-pip py3-requests py3-yaml gzip findutils && \
    pip3 install crontab --break-system-packages && \
    # install elasticdump \
    apk add --update --no-cache npm && \
    # install postgresql client
    apk add --update --no-cache postgresql18-client

WORKDIR /usr/bin/
ENV BACKUP_ROOT=/backup
VOLUME /backup
ADD *.py /scripts/
USER 1000
ENTRYPOINT ["/sbin/tini","--"]
CMD /scripts/backup_client.py schedule @daily
