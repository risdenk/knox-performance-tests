FROM openjdk:8-jdk

RUN apt-get install wget

RUN useradd -m -u 1000 hive

ENV HIVE_VERSION=3.1.0
ENV HIVE_FOLDER=apache-hive-${HIVE_VERSION}-bin
ENV HIVE_TAR=${HIVE_FOLDER}.tar.gz

RUN wget --quiet -O /opt/${HIVE_TAR} "https://www.apache.org/dyn/closer.cgi?filename=hive/hive-${HIVE_VERSION}/${HIVE_TAR}&action=download" && tar zxf /opt/${HIVE_TAR} -C /opt && rm /opt/${HIVE_TAR} && ln -nsf /opt/${HIVE_FOLDER} /opt/hive && chown -R hive /opt/hive/

USER hive
WORKDIR /opt/hive

ENV HADOOP_HOME=/opt/hadoop
ENV HIVE_HOME=/opt/hive

COPY entrypoint.sh /entrypoint.sh
ENTRYPOINT ["/entrypoint.sh"]

