To run agents, use following command:

    docker.io run -v /var/build-agent -dt --name teamcity_agentN \
    -p 909N:909N mlapshin/teamcity-agent \
    "/var/build-agent/run-agent.sh" \
    "http://172.17.42.1:8111" "agentN" "909N"