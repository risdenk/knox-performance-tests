FROM openjdk:8-jdk

RUN apt-get install wget

RUN useradd -u 1000 knox

ENV KNOX_VERSION=1.3.0-SNAPSHOT
ENV KNOX_FOLDER=knox-${KNOX_VERSION}
ENV KNOX_TAR=gateway-release-${KNOX_VERSION}.tar.gz

RUN wget --quiet -O /opt/${KNOX_TAR} "https://builds.apache.org/job/Knox-master-daily/lastSuccessfulBuild/org.apache.knox\$gateway-release/artifact/org.apache.knox/gateway-release/${KNOX_VERSION}/${KNOX_TAR}" && tar zxf /opt/${KNOX_TAR} -C /opt && rm /opt/${KNOX_TAR} && ln -nsf /opt/${KNOX_FOLDER} /opt/knox && chown -R knox /opt/knox/

COPY --chown=knox gateway-site.xml /opt/knox/conf/gateway-site.xml
COPY --chown=knox sandbox.xml /opt/knox/conf/topologies/sandbox.xml

USER knox

RUN /opt/knox/bin/knoxcli.sh create-master --generate

COPY ldap.sh /ldap.sh
COPY gateway.sh /gateway.sh

