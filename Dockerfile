FROM        python:alpine

LABEL       maintainer="ksurl"

COPY        tunnel.py /etc/tunnel/tunnel.py
COPY        init /init

ENV         PUID=1000 \
            PGID=1000 \
            SSH_PORT=22

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
