FROM maven AS builder

RUN apt update && apt install -y git

RUN rm -rf /var/cache/apt/archives /var/lib/apt/lists/*

RUN git clone https://gitee.com/pengzhile/atlassian-agent.git

WORKDIR atlassian-agent

RUN mvn package

RUN rm -rf ~/.m2/repository

FROM cptactionhank/atlassian-confluence:latest

USER root

COPY --from=builder /atlassian-agent/target/atlassian-agent-jar-with-dependencies.jar /opt/atlassian/confluence/atlassian-agent.jar

RUN echo 'export CATALINA_OPTS="-javaagent:/opt/atlassian/confluence/atlassian-agent.jar ${CATALINA_OPTS}"' >> /opt/atlassian/confluence/bin/setenv.sh
