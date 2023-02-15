#!/usr/bin/env bash

sketchybar -m --add item sound.output right              \
              --set sound.output                         \
                    update_freq=10                       \
                    script="$PLUGIN_DIR/sound.output.sh" \
              --subscribe sound.output volume_change