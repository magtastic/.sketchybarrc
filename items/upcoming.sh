#!/usr/bin/env bash

sketchybar --add item upcoming right                                                       \
           --set upcoming label.color=$COLOR_DEFAULT_ICON                            \
                          update_freq=20                                                   \
                          updates=on                                                       \
                          background.color=$COLOR_BAR                                      \
                          popup.blur_radius=25                                             \
                          popup.background.corner_radius=4                                 \
                          popup.background.color=0xff000000                                \
                          popup.height=26                                                  \
                          script="python3 $PLUGIN_DIR/upcoming.py"                         \
                          click_script="sketchybar -m --set upcoming popup.drawing=toggle"
