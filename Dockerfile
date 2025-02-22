ARG BUILD_FROM
FROM $BUILD_FROM

RUN \
  apk add --no-cache \
  python3 py3-pip git

RUN pip install --break-system-packages paho-mqtt

RUN git clone https://github.com/berwinter/redac2mqtt.git

WORKDIR redac2mqtt
COPY run.sh /
RUN chmod a+x /run.sh

CMD [ "/run.sh" ]