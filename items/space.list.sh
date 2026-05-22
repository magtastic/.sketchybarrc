#!/usr/bin/env bash

# Each workspace's display is whatever monitor aerospace currently has it on.
# That follows aerospace.toml's [workspace-to-monitor-force-assignment]
# fallback chain — so unplug the externals and everything lands on the laptop
# bar; plug them back in and items split across the bars again.
#
# space.list.ts also re-applies `display` on every event, so it stays in sync
# when monitors come and go (subscribed to `display_change` below).

ws_map=$(aerospace list-workspaces --all --format '%{workspace}=%{monitor-id}' 2>/dev/null)

display_for_workspace() {
    local idx=$1
    local m
    m=$(echo "$ws_map" | grep -m1 "^${idx}=" | cut -d= -f2)
    echo "${m:-1}"
}

for index in $(seq 1 9); do
    display=$(display_for_workspace "$index")

    sketchybar --add item "space.list.${index}" left                                   \
            --set "space.list.${index}" updates=on                                     \
                                        display=${display}                             \
                                        icon=${index}                                  \
                                        icon.font="SF Pro:Bold:13.0"                   \
                                        icon.color=$COLOR_TEXT_MUTED                   \
                                        icon.highlight_color=$COLOR_ACCENT_ON          \
                                        icon.padding_left=8                            \
                                        icon.padding_right=4                           \
                                        label.font="SF Pro Display:Semibold:14.0"      \
                                        label.color=$COLOR_TEXT                        \
                                        label.highlight_color=$COLOR_ACCENT_ON         \
                                        label.padding_left=2                           \
                                        label.padding_right=8                          \
                                        background.color=$COLOR_ACCENT                 \
                                        background.corner_radius=6                     \
                                        background.height=24                           \
                                        background.drawing=off                         \
                                        background.padding_left=2                      \
                                        background.padding_right=2                     \
                                        script="$PLUGIN_DIR/space.list.ts"             \
                                        click_script="aerospace workspace ${index}"    \
            --subscribe "space.list.${index}" aerospace_workspace_change front_app_switched display_change
done
