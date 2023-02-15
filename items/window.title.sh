#!/usr/bin/env bash

sketchybar --add item              window.title left                                      \
           --set window.title      drawing=on                                             \
                                   script="$PLUGIN_DIR/window.title.sh"                   \
                                   updates=on                                             \
                                   icon.font="SF Pro:Heavy:13.0"                          \
                                   icon.color=$COLOR_DESACTIVATED_ICON                    \
                                   label.color=$COLOR_DESACTIVATED_LABEL                  \
                                                                                          \
          --add event              window_title_changed                                   \
                                                                                          \
          --subscribe window.title front_app_switched display_change window_title_changed