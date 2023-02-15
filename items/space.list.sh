#!/usr/bin/env bash

SPACE_ICONS=("1" "2" "3" "4" "5" "6" "7" "8" "9" "0")

for i in "${!SPACE_ICONS[@]}"; do
    index=$(($i+1))

    sketchybar --add space "space.list.${index}" left                                  \
            --set "space.list.${index}" associated_space=${index}                      \
                                                                                       \
                                        icon=${SPACE_ICONS[i]}                         \
                                        icon.width=24                                  \
                                        icon.align=center                              \
                                        icon.color=$COLOR_DEFAULT_ICON                 \
                                        icon.highlight_color=$COLOR_DEFAULT_ICON       \
                                                                                       \
                                        background.color=$COLOR_BACKGROUND_HIGHLIGHTED \
                                        background.height=24                           \
                                        icon.font="SF Pro:Bold:14.0"                   \
                                                                                       \
                                        background.drawing=off                         \
                                        label.drawing=off                              \
                                                                                       \
                                        script="$PLUGIN_DIR/space.list.sh"             \
                                        click_script="yabai -m space --focus ${index}"
done