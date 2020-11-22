# Docker image for ssh tunnels based on python script from [sshtunneller](https://github.com/jossec101/sshtunneller) by [jossec101](https://github.com/jossec101)

* Based on python:alpine

# Usage

## docker cli

    docker run -d \
        --name=tunnel \
        -v ./sshkey:/private.key \
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
        ksurl/sshtunnel

## docker-compose 

    version: "2"
    services:
      redbot:
        image: ksurl/sshtunnel:latest
        container_name: tunnel
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
          - ./sshkey:/private.key
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
| `-v ./sshkey:/private.key` | bindmount for private key | `./sshkey` |
