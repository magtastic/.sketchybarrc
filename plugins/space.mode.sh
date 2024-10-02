#!/usr/bin/env bash

QUERY=$(yabai -m query --windows --window)
WINDOW=$(yabai -m query --spaces --space)

DEFAULT="􀛧"

case "$(echo "$QUERY" | jq -r '.app')" in
    "iTerm2")
      icon="􀩼"
      ;;
    "Xcode")
      icon="􀷔"
      ;;
    "SF Symbols")
      icon="􁂮"
      ;;
    "Firefox Developer Edition")
      icon="􀤆"
      ;;
    "Simulator")
      icon="􀟜"
      ;;
    "App Store")
      icon="􀈄"
      ;;
    "Notion")
      icon="􀺴"
      ;;
    "1Password")
      icon="􀙵"
      ;;
    "Arc")
      icon="􀎬"
      ;;
    "Safari")
      icon="􀎬"
      ;;
    "Google Chrome")
      icon="􀎬"
      ;;
    "Messages")
      icon="􀌤"
      ;;
    "Messenger")
      icon="􀌤"
      ;;
    "Polymail")
      icon="􀍕"
      ;;
    "Cron")
      icon="􀉉"
      ;;
    "zoom.us")
      icon="􀍉"
      ;;
    "Asana")
      icon="􀷾"
      ;;
    "Install Command Line Developer Tools")
      icon="􀌤"
      ;;
    "Slack")
      icon="􀃪"
      ;;
    "System Settings")
      icon="􀣋"
      ;;
    "Postman")
      icon="􀪹"
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
