FROM ubuntu:20.04
LABEL author="Tarun"
LABEL application="spring-petclinic"
ARG branch=docker
RUN apt update && \
    apt install openjdk-11-jdk -y && \
    apt install git -y && \
    apt install maven -y && \
    git clone https://github.com/tarunkumarpendem/spring-petclinic.git && \
    cd spring-petclinic && \
    git checkout ${branch} && \
    mvn clean package
EXPOSE 8080 