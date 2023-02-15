#!/usr/bin/env bash

QUERY=$(yabai -m query --windows --window & disown)
TITLE=$(echo "$QUERY" | jq -r '.title')
ACT_DISPLAY=$(echo "$QUERY" | jq -r '.display')

if [ "${INFO}" == "" ]; then
    INFO=$(echo "$QUERY" | jq -r '.app')
fi

if [[ ${#TITLE} -gt 50 ]]; then
    TITLE="$(echo "$TITLE" | cut -c 1-50)..."
fi

case "$SENDER" in
    "front_app_switched"|"window_title_changed") sketchybar --set $NAME icon="${INFO}"
    ;;
    "display_change") sketchybar --set $NAME associated_display=$INFO
    ;;
esac
