FROM openjdk:8-jdk

RUN apt-get install wget

RUN useradd -u 1000 jmeter

ENV JMETER_VERSION=5.0
ENV JMETER_FOLDER=apache-jmeter-${JMETER_VERSION}
ENV JMETER_TAR=${JMETER_FOLDER}.tgz

RUN wget -O /opt/${JMETER_TAR} "https://www.apache.org/dyn/closer.cgi?filename=jmeter/binaries/${JMETER_TAR}&action=download" && tar zxvf /opt/${JMETER_TAR} -C /opt && rm /opt/${JMETER_TAR} && ln -nsf /opt/${JMETER_FOLDER} /opt/jmeter && chown -R jmeter /opt/jmeter/

USER jmeter

COPY entrypoint.sh /entrypoint.sh

ENTRYPOINT /entrypoint

