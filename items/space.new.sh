#!/usr/bin/env bash

sketchybar -m --add item space.new left         \
              --set space.new icon=􀅼           \
                              label.drawing=off \
                              click_script="yabai -m space --create && sketchybar --update & disown"