FROM debian:bullseye

RUN apt update && apt upgrade -y

RUN apt install wget -y

WORKDIR /usr/local/bin

RUN wget https://github.com/google/cadvisor/releases/download/v0.40.0/cadvisor
RUN chmod +x cadvisor

ENTRYPOINT	[ "cadvisor" ]
