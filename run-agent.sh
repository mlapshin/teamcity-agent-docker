#!/bin/sh

AGENT_CONFIG=/var/build-agent/conf/buildAgent.properties

if [ ! -f "$AGENT_CONFIG" ]; then
    cp /var/build-agent/conf/buildAgent.dist.properties $AGENT_CONFIG
    sed -i.bak "s@serverUrl=http://localhost:8111/@serverUrl=$1@g" $AGENT_CONFIG
    sed -i.bak "s@name=@name=$2@g" $AGENT_CONFIG
    sed -i.bak "s@ownPort=9090@ownPort=$3@g" $AGENT_CONFIG
fi

export HOME=/home/agent
export AGENT_NAME=$2

/var/build-agent/bin/agent.sh run
