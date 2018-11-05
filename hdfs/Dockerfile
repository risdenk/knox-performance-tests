FROM openjdk:8-jdk

RUN apt-get install wget

RUN useradd -u 1000 hdfs

ENV HADOOP_VERSION=3.1.1
ENV HADOOP_FOLDER=hadoop-${HADOOP_VERSION}
ENV HADOOP_TAR=${HADOOP_FOLDER}.tar.gz

RUN wget --quiet -O /opt/${HADOOP_TAR} "https://www.apache.org/dyn/closer.cgi?filename=hadoop/core/${HADOOP_FOLDER}/${HADOOP_TAR}&action=download" && tar zxf /opt/${HADOOP_TAR} -C /opt && rm /opt/${HADOOP_TAR} && rm -r /opt/${HADOOP_FOLDER}/share/doc && ln -nsf /opt/${HADOOP_FOLDER} /opt/hadoop

ENV HADOOP_HOME=/opt/hadoop
WORKDIR /opt/hadoop

RUN chown -R hdfs /opt/hadoop

RUN apt-get update && DEBIAN_FRONTEND=noninteractive apt-get install -y krb5-user

USER hdfs
RUN bin/hdfs namenode -format

COPY --chown=hdfs hdfs-site.xml /opt/hadoop/etc/hadoop/hdfs-site.xml
COPY --chown=hdfs core-site.xml /opt/hadoop/etc/hadoop/core-site.xml

COPY entrypoint.sh /entrypoint.sh
ENTRYPOINT "/entrypoint.sh"

