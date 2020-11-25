FROM        python:alpine

LABEL       org.opencontainers.image.source="https://github.com/ksurl/docker-sshtunnel"

LABEL       maintainer="ksurl"

ENV         PUID=1000 \
            PGID=1000 \
            SSH_PORT=22

COPY        root/ /

RUN         chmod +x \
                /etc/tunnel/tunnel.py \
                /init && \
            apk add --no-cache --virtual .build-deps \
                gcc \
                make \
                libffi-dev \
                musl-dev && \
			      apk add --no-cache \
		            dumb-init \
                libressl-dev \
                su-exec && \
            pip install --no-cache-dir \
                sshtunnel && \
            apk del --purge --no-cache .build-deps && \
            rm -rf /tmp/* /var/cache/apk/* /root/.cache

ENTRYPOINT  [ "/usr/bin/dumb-init", "--" ]
CMD         [ "/init" ]
