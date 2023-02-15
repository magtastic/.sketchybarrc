#!/usr/bin/env bash

sketchybar -m --add item network.wifi right                  \
              --set network.wifi icon=􀙇                     \
                        updates=on                           \
                        label.drawing=off                    \
                        update_freq=3                        \
                        script="$PLUGIN_DIR/network.wifi.sh"