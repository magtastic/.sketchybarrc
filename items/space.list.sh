#!/usr/bin/env bash

SPACE_ICONS=("􀀺" "􀀼" "􀀾" "􀁀" "􀁂" "􀁄" "􀁆" "􀁈" "􀁊" "􀓵" "􀓶" "􀓷" "􀓸")

for i in "${!SPACE_ICONS[@]}"; do
    index=$(($i+1))

    sketchybar --add space "space.list.${index}" left                                  \
            --set "space.list.${index}" associated_space=${index}                      \
                                        icon=${SPACE_ICONS[i]}                         \
                                        icon.width=22                                  \
                                        icon.align=center                              \
                                        icon.color=$COLOR_DEFAULT_ICON                 \
                                        icon.highlight_color=$COLOR_ACTIVATED_ICON                \
                                        icon.font="SF Pro:Bold:17.0"                   \
                                        background.drawing=off                         \
                                        label.drawing=off                              \
                                        script="$PLUGIN_DIR/space.list.sh"             \
                                        click_script="yabai -m space --focus ${index}"
done
