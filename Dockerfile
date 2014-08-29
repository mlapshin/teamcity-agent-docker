FROM ubuntu:14.04

RUN apt-get update
RUN apt-get install -y --no-install-recommends wget openjdk-7-jdk wget unzip build-essential git man postgresql-client-9.3 openssh-client firefox xvfb
RUN mkdir -p /var/build-agent/
RUN mkdir -p /var/build-agent/work

ADD buildAgent.zip /tmp/buildAgent.zip
RUN unzip /tmp/buildAgent.zip -d /var/build-agent/
ADD run-agent.sh /var/build-agent/run-agent.sh

RUN adduser --disabled-password --gecos "" agent
RUN chown -R agent /var/build-agent
RUN chmod +x /var/build-agent/bin/agent.sh
RUN chmod +x /var/build-agent/run-agent.sh

VOLUME ["/var/build-agent"]

# install leiningen
RUN wget -O /usr/bin/lein https://raw.github.com/technomancy/leiningen/stable/bin/lein
RUN chmod +x /usr/bin/lein

RUN mkdir -p /home/agent/.lein/profiles.d/
ADD teamcity.clj /home/agent/.lein/profiles.d/teamcity.clj
ADD selenese-runner.jar /home/agent/selenese-runner.jar
RUN chown -R agent /home/agent/

# install nvm
RUN su agent -c 'wget -qO- https://raw.githubusercontent.com/creationix/nvm/v0.7.0/install.sh | sh'
RUN su agent -c "bash -c '. ~/.nvm/nvm.sh && nvm install 0.10'"

# configure en_US.UTF-8 locale
RUN locale-gen en_US.UTF-8
ENV LANG en_US.UTF-8
ENV LANGUAGE en_US:en
ENV LC_ALL en_US.UTF-8  