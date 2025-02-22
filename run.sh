#!/usr/bin/with-contenv bashio

METER="meter.txt"
OPTIONS=""

bashio::log.info "Creating Config..."

DEVICE=$(bashio::config 'device')
USERNAME=$(bashio::config 'mqtt_broker_username')
PASSWORD=$(bashio::config 'mqtt_broker_password')
HOSTNAME=$(bashio::config 'mqtt_broker_host')
PORT=$(bashio::config 'mqtt_broker_port')

MQTT="mqtt://$USERNAME:$PASSWORD@$HOSTNAME:$PORT"

if bashio::config.true 'hass'; then
    bashio::log.info "Enable Home Assistant Discovery"
    OPTIONS+=" --hass"
fi

if bashio::config.true 'debug'; then
    bashio::log.info "Enable Debug Messages"
    OPTIONS+=" --debug"
fi

for id in $(bashio::config 'meters.ids'); do
    echo $id >> $METER
done

bashio::log.info "Starting redac2mqtt..."
python3 ./redac2mqtt.py $DEVICE $METER --mqtt $MQTT $OPTIONS
