FROM java
MAINTAINER Prometheus Team <prometheus-developers@googlegroups.com>
EXPOSE 9106

RUN apt-get -qy update && apt-get -qy install maven

WORKDIR /cloudwatch_exporter
ADD . /cloudwatch_exporter
RUN mvn package && mv target/cloudwatch_exporter-*-with-dependencies.jar /cloudwatch_exporter.jar && \
    rm -rf /cloudwatch_exporter
WORKDIR /

ADD config.json /
ENTRYPOINT [ "java", "-jar", "/cloudwatch_exporter.jar", "9106", "/config.json" ]
