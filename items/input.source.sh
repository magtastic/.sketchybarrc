
sketchybar --add event input_change 'AppleSelectedInputSourcesChangedNotification' \
           --add item input right                                                  \
           --set input script="$PLUGIN_DIR/input.source.ts"                        \
           --subscribe input input_change

