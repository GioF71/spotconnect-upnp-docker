from debian:stable-slim

VOLUME /config

RUN apt-get update
RUN apt-get install -y wget unzip

RUN mkdir /app/bin -p
COPY app/bin/install.sh /app/bin/
RUN chmod u+x /app/bin/install.sh
WORKDIR /app/bin/
RUN /app/bin/install.sh

RUN ls -la /app/bin

RUN apt-get remove -y wget unzip

COPY app/bin/run.sh /app/bin
RUN chmod 755 /app/bin/run.sh

WORKDIR /app/bin
ENTRYPOINT ["/app/bin/run.sh"]