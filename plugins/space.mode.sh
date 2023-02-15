#!/usr/bin/env bash

QUERY=$(yabai -m query --windows --window)
WINDOW=$(yabai -m query --spaces --space)

DEFAULT="􀛧"

case "$(echo "$QUERY" | jq -r '.app')" in
    "iTerm2")
      icon="􀩼"
      ;;
    "SF Symbols")
      icon="􁂮"
      ;;
    "Firefox Developer Edition")
      icon="􀤆"
      ;;
    "Messages")
      icon="􀌤"
      ;;
    "Messenger")
      icon="􀌤"
      ;;
    "Install Command Line Developer Tools")
      icon="􀌤"
      ;;
    "Slack")
      icon="􀃪"
      ;;
    "Finder")
      icon="􀈕"
      ;;
    *)
      icon=$DEFAULT
      ;;
esac

case "$SENDER" in
    "front_app_switched"|"space_mode_changed") sketchybar --set $NAME icon="${icon}"
    ;;
    "display_change") sketchybar --set $NAME associated_display=$INFO
    ;;
esac
