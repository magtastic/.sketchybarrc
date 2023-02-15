#!/usr/bin/env bash

sketchybar -m --add item network.vpn right                  \
              --set network.vpn icon=􀌋                     \
                        updates=on                          \
                        label.drawing=off                   \
                        update_freq=5                       \
                        script="$PLUGIN_DIR/network.vpn.sh"