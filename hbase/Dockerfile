FROM openjdk:8-jdk

RUN apt-get install wget

RUN useradd -u 1000 hbase

ENV HBASE_VERSION=2.1.0
ENV HBASE_FOLDER=hbase-${HBASE_VERSION}
ENV HBASE_TAR=${HBASE_FOLDER}-bin.tar.gz

RUN wget -O /opt/${HBASE_TAR} "https://www.apache.org/dyn/closer.cgi?filename=hbase/${HBASE_VERSION}/${HBASE_TAR}&action=download" && tar zxvf /opt/${HBASE_TAR} -C /opt && rm /opt/${HBASE_TAR} && ln -nsf /opt/${HBASE_FOLDER} /opt/hbase && chown -R hbase /opt/hbase/

USER hbase

COPY entrypoint.sh /entrypoint.sh
ENTRYPOINT "/entrypoint.sh"

