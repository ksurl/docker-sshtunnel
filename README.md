# Docker image for ssh tunnels based on [jossec101/sshtunneller](https://github.com/jossec101/sshtunneller)

[![](https://img.shields.io/badge/Docker%20Hub--blue)](https://hub.docker.com/r/ksurl/sshtunnel) [![](https://img.shields.io/badge/GitHub%20Container%20Registry--yellow)](https://github.com/users/ksurl/packages/container/package/sshtunnel)

[![](https://img.shields.io/github/v/tag/ksurl/docker-sshtunnel?label=image%20version&logo=docker)](https://hub.docker.com/r/ksurl/sshtunnel) [![](https://img.shields.io/docker/image-size/ksurl/sshtunnel/latest?color=lightgrey&logo=Docker)]() [![](https://img.shields.io/github/workflow/status/ksurl/docker-sshtunnel/build?label=build&logo=Docker)](https://github.com/ksurl/docker-sshtunnel/actions?query=workflow%3Abuild)

* Based on python:alpine
* dumb-init
* non-root user

# Usage

## docker cli

    docker run -d \
        --name=sshtunnel \
        -v ./sshkey:/private.key:ro \
        -p 80:80 \ # change port as needed
        -e PUID=1000 \
        -e PGID=1000 \
        -e SSH_HOST=host \
        -e SSH_PORT=22 \
        -e SSH_USERNAME=root \
        #-e SSH_PASSWORD=password \
        -e SSH_PRIVATE_KEY_PASSWORD=password \
        -e REMOTE_BIND_ADDRESSES=[("127.0.0.1", 80)] \ # change port as needed
        -e LOCAL_BIND_ADDRESSES=[("0.0.0.0", 80)] \ # change port as needed
        ghcr.io/ksurl/sshtunnel

## docker-compose 

    version: "3.8"
    services:
      redbot:
        image: ghcr.io/ksurl/sshtunnel
        container_name: sshtunnel
        ports:
          - 80:80 # change ports as needed
        environment:
          - PUID=1000
          - PGID=1000
          - SSH_HOST=host
          - SSH_PORT=22
          - SSH_USERNAME=root
          #- SSH_PASSWORD=password
          - SSH_PRIVATE_KEY_PASSWORD=password
          - REMOTE_BIND_ADDRESSES=[("127.0.0.1", 80)] # change port as needed
          - LOCAL_BIND_ADDRESSES=[("0.0.0.0", 80)] # change port as needed
        volumes:
          - ./sshkey:/private.key:ro
        restart: always

## Parameters

| Parameter | Function | Default |
| :----: | --- | --- |
| `-e PUID` | Set uid | `1000` |
| `-e PGID` | Set gid | `1000` |
| `-e SSH_HOST` | Set fqdn or IP Address of host | |
| `-e SSH_PORT` | Set ssh port of host | `22` |
| `-e SSH_USERNAME` | Set username | |
| `-e SSH_PASSWORD` | Set password. Optional if using key authentication | | 
| `-e SSH_PRIVATE_KEY_PASSWORD` | Set private key password. If blank, use `""` | |
| `-e REMOTE_BIND_ADDRESSES` | List of remote ports to bind. List multiple in comma separated parentheses | |
| `-e LOCAL_BIND_ADDRESSES` | List of local ports to bind. List multiple matching REMOTE_BIND_ADDRESSES | |
| `-p 80:80` | Expose ports as needed | |
| `-v ./sshkey:/private.key:ro` | bindmount for private key | |
