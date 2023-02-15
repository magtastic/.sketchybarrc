#!/usr/bin/env bash

source "$(dirname $(dirname $0))/colors.sh"

LEVEL=50

VOLUME=$(osascript -e 'input volume of (get volume settings)')

if [ $VOLUME == 0 ]; then
    osascript -e "set volume input volume ${LEVEL}"
    sketchybar --set $NAME icon="􀊱" icon.color=$COLOR_WARNING_ICON
else
    osascript -e 'set volume input volume 0'
    sketchybar --set $NAME icon="􀊲" icon.color=$COLOR_DEFAULT_ICON
fi
