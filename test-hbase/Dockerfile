FROM openjdk:8-jdk

RUN apt-get update && apt-get install -y time

COPY generate_data.py /generate_data.py
COPY entrypoint.sh /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]

