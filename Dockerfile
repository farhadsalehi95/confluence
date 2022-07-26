FROM cptactionhank/atlassian-confluence:latest

USER root

COPY atlassian-agent-jar.jar /opt/atlassian/confluence/atlassian-agent.jar

RUN echo 'export CATALINA_OPTS="-javaagent:/opt/atlassian/confluence/atlassian-agent.jar ${CATALINA_OPTS}"' >> /opt/atlassian/confluence/bin/setenv.sh
