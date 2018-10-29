FROM openjdk:8-jdk

RUN apt-get update && apt-get install -y time

COPY entrypoint.sh /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]

