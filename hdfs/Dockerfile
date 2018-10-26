FROM openjdk:8-jdk

RUN apt-get install wget

RUN useradd -u 1000 hdfs

ENV HADOOP_VERSION=3.1.1
ENV HADOOP_FOLDER=hadoop-${HADOOP_VERSION}
ENV HADOOP_TAR=${HADOOP_FOLDER}.tar.gz

RUN wget -O /opt/${HADOOP_TAR} "https://www.apache.org/dyn/closer.cgi?filename=hadoop/core/${HADOOP_FOLDER}/${HADOOP_TAR}&action=download" && tar zxvf /opt/${HADOOP_TAR} -C /opt && rm /opt/${HADOOP_TAR} && ln -nsf /opt/${HADOOP_FOLDER} /opt/hadoop && chown -R hdfs /opt/hadoop/

USER hdfs

COPY entrypoint.sh /entrypoint.sh
ENTRYPOINT "/entrypoint.sh"

