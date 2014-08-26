FROM ubuntu:14.04

RUN apt-get update
RUN apt-get install -y --no-install-recommends wget default-jre wget unzip
RUN mkdir -p /var/build-agent/
RUN mkdir -p /var/build-agent/work

ADD buildAgent.zip /tmp/buildAgent.zip
RUN unzip /tmp/buildAgent.zip -d /var/build-agent/
ADD run-agent.sh /var/build-agent/run-agent.sh

RUN adduser --disabled-password --gecos "" agent
RUN chown -R agent /var/build-agent
RUN chmod +x /var/build-agent/bin/agent.sh
RUN chmod +x /var/build-agent/run-agent.sh

VOLUME ["/var/build-agent/work"]