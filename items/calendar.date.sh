#!/usr/bin/env bash

sketchybar --add item calendar.date right                            \
           --set calendar.date update_freq=30                        \
                               script="$PLUGIN_DIR/calendar.date.sh"
