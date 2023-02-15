#!/usr/bin/env bash

WIFI_OFF=$(ifconfig en0 | awk '/status:/{print $2}')

if [ "$WIFI_OFF" == "active" ]; then
    sketchybar -m --set $NAME drawing=on
else
    sketchybar -m --set $NAME drawing=off
fi