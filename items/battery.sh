#!/usr/bin/env bash

sketchybar --add       item battery right                          \
           --set       battery                                     \
                       update_freq=10                              \
                       script="$PLUGIN_DIR/battery.sh"             \
                       click_script="$PLUGIN_DIR/battery.click.sh" \
           --add       event caffeinate                            \
           --subscribe battery caffeinate