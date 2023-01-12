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
WORKDIR /spring-petclinic    
EXPOSE 8080 
CMD ["java", "-jar", "target/spring-petclinic-2.7.3.jar"]