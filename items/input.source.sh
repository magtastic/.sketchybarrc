
sketchybar --add event input_change 'AppleSelectedInputSourcesChangedNotification' \
           --add item input right                                                  \
           --set input script="$PLUGIN_DIR/input.source.ts"                        \
                       background.padding_left=8                                   \
                       background.padding_right=8                                  \
           --subscribe input input_change

