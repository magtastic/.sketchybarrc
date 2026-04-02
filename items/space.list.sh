#!/usr/bin/env bash

for index in $(seq 1 13); do
    sketchybar --add space "space.list.${index}" left                                  \
            --set "space.list.${index}" associated_space=${index}                      \
                                        icon=${index}                                  \
                                        icon.font="SF Pro:Bold:11.0"                   \
                                        icon.color=0xffffffff                          \
                                        icon.highlight_color=$COLOR_ACTIVATED_ICON     \
                                        icon.y_offset=6                                \
                                        icon.padding_right=-2                          \
                                        icon.align=left                                \
                                        label.font="SF Pro Display:Semibold:16.0"     \
                                        label.color=0xffffffff                         \
                                        label.highlight_color=$COLOR_ACTIVATED_ICON    \
                                        label.drawing=on                               \
                                        label.padding_left=2                           \
                                        background.drawing=off                         \
                                        background.padding_left=6                      \
                                        background.padding_right=6                     \
                                        script="$PLUGIN_DIR/space.list.ts"             \
                                        click_script="yabai -m space --focus ${index}" \
            --subscribe "space.list.${index}" space_change front_app_switched
done
