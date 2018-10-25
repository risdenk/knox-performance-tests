FROM openjdk:8-jdk

RUN apt-get install wget

RUN useradd -u 1000 knox

ENV KNOX_VERSION=1.1.0
ENV KNOX_FOLDER=knox-${KNOX_VERSION}
ENV KNOX_TAR=${KNOX_FOLDER}.tar.gz

RUN wget -O /opt/${KNOX_TAR} "https://www.apache.org/dyn/closer.cgi?filename=knox/${KNOX_VERSION}/${KNOX_TAR}&action=download" && tar zxvf /opt/${KNOX_TAR} -C /opt && rm /opt/${KNOX_TAR} && ln -nsf /opt/${KNOX_FOLDER} /opt/knox && chown -R knox /opt/knox/

USER knox

RUN /opt/knox/bin/knoxcli.sh create-master --generate

COPY entrypoint.sh /entrypoint.sh
ENTRYPOINT "/entrypoint.sh"

