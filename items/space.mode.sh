#!/usr/bin/env bash

sketchybar --add item             space.mode left                                      \
           --set space.mode       drawing=on                                           \
                                  updates=on                                           \
                                  script="$PLUGIN_DIR/space.mode.sh"                   \
                                  icon.color=$COLOR_DESACTIVATED_ICON                  \
                                  label.drawing=off                                    \
           --add event            space_mode_changed                                   \
           --subscribe space.mode space_mode_changed front_app_switched display_change