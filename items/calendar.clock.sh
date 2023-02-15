#!/usr/bin/env bash

sketchybar --add item calendar.clock right                             \
           --set calendar.clock update_freq=1                          \
                                icon=􀐫                                \
                                background.padding_left=0              \
                                label.padding_left=0                   \
                                icon.drawing=off                       \
                                script="$PLUGIN_DIR/calendar.clock.sh"