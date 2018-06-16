FROM logstash:alpine

RUN logstash-plugin install --no-verify --local logstash-input-log4j logstash-output-elasticsearch logstash-input-tcp logstash-input-udp