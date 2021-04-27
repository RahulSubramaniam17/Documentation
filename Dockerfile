FROM docker.elastic.co/beats/filebeat:7.12.0
COPY filebeat.yaml /usr/share/filebeat/filebeat.yml
USER root
RUN chown root:filebeat /usr/share/filebeat/filebeat.yml
USER filebeat