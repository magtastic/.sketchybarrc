#!/usr/bin/env bash

source "$(dirname $(dirname $0))/colors.sh"

VOLUME=$(osascript -e 'input volume of (get volume settings)')

if [ $VOLUME == 0 ]; then
    icon="􀊲"
    color=$COLOR_DEFAULT_ICON
else
    icon="􀊱"
    color=$COLOR_WARNING_ICON
fi

ALLOWED_INPUTS=('External Microphone' 'MacBook Pro Microphone')
ACTUAL_INPUT=$(SwitchAudioSource -t input -c & disown)

if [[ ! "${ALLOWED_INPUTS[*]}" =~ "${ACTUAL_INPUT}" ]]; then
    icon="􁙄"
    color=$COLOR_ATTENTION_ICON
fi

sketchybar --set $NAME icon="${icon}" icon.color="${color}"