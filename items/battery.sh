#!/usr/bin/env bash

sketchybar --add       item battery right                          \
           --set       battery                                     \
                       update_freq=10                              \
                       script="$PLUGIN_DIR/battery.ts"             \
                       click_script="$PLUGIN_DIR/battery.click.ts" \
           --add       event caffeinate                            \
           --subscribe battery caffeinate
