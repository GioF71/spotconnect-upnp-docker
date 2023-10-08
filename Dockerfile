from debian:stable-slim

LABEL maintainer="GioF71"
LABEL source="https://github.com/GioF71/spotconnect-upnp-docker"

ENV PUID ""
ENV PGID ""
ENV PREFER_STATIC ""

VOLUME /config

RUN mkdir /app/bin -p
COPY app/bin/install.sh /app/bin/
RUN chmod u+x /app/bin/install.sh
WORKDIR /app/bin/
RUN /app/bin/install.sh
RUN rm /app/bin/install.sh

COPY app/bin/run.sh /app/bin
RUN chmod 755 /app/bin/run.sh

WORKDIR /app/bin
ENTRYPOINT ["/app/bin/run.sh"]