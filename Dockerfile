FROM ubuntu:14.04

RUN apt-get update
RUN apt-get install -y --no-install-recommends wget default-jre wget unzip
RUN mkdir -p /var/build-agent/
VOLUME /var/build-agent

ADD buildAgent.zip /tmp/buildAgent.zip
RUN unzip /tmp/buildAgent.zip -d /var/build-agent/
ADD run-agent.sh /var/build-agent/bin/run-agent.sh

RUN adduser --disabled-password --gecos "" agent
RUN chown -R agent /var/build-agent
RUN chmod +x /var/build-agent/bin/agent.sh
RUN chmod +x /var/build-agent/bin/run-agent.sh
