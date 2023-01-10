# FROM ubuntu:20.04
# RUN apt update 
# RUN apt install openjdk-11-jdk wget -y
# RUN wget https://referenceapplicationskhaja.s3.us-west-2.amazonaws.com/spring-petclinic-2.4.2.jar
# EXPOSE 8080
# CMD ["java", "-jar", "/spring-petclinic-2.4.2.jar"]


FROM ubuntu:20.04
LABEL author="Tarun"
LABEL app="spring-petclinic"
RUN apt update && \
    apt install openjdk-11-jdk git maven -y && \
    git clone https://github.com/tarunkumarpendem/spring-petclinic.git && \
    cd spring-petclinic  
ARG branch=docker
RUN git checkout ${branch} && \  
    mvn clean install
EXPOSE 8080
CMD [ "java", "-jar". "/spring-petclinic-2.7.3.jar" ]


