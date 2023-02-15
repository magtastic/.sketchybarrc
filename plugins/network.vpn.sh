#!/usr/bin/env bash

VPN=$(scutil --nc list | grep Connected | sed -E 's/.*"(.*)".*/\1/')

if [[ $VPN != "" ]]; then
    sketchybar -m --set $NAME icon=􀢖 drawing=on
else
    sketchybar -m --set $NAME drawing=off
fi