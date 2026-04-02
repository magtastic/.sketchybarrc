#!/usr/bin/env bash

sketchybar -m --add item sound.output right              \
              --set sound.output                         \
                    update_freq=10                       \
                    background.padding_left=8            \
                    background.padding_right=8           \
                    script="$PLUGIN_DIR/sound.output.ts" \
              --subscribe sound.output volume_change