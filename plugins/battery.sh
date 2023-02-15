#!/usr/bin/env bash

source "$(dirname $(dirname $0))/colors.sh"

data=$(pmset -g batt)
battery_percent=$(echo $data | grep -Eo "\d+%" | cut -d% -f1)
charging=$(echo $data | grep 'AC Power')

case "$battery_percent" in
    100)    icon="􀛨" color=$COLOR_DEFAULT_ICON ;;
    9[0-9]) icon="􀛨" color=$COLOR_DEFAULT_ICON ;;
    8[0-9]) icon="􀛨" color=$COLOR_DEFAULT_ICON ;;
    7[0-9]) icon="􀺶" color=$COLOR_DEFAULT_ICON ;;
    6[0-9]) icon="􀺶" color=$COLOR_DEFAULT_ICON ;;
    5[0-9]) icon="􀺶" color=$COLOR_DEFAULT_ICON ;;
    4[0-9]) icon="􀺶" color=$COLOR_DEFAULT_ICON ;;
    3[0-9]) icon="􀛩" color=$COLOR_DEFAULT_ICON ;;
    2[0-9]) icon="􀛩" color=$COLOR_DEFAULT_ICON ;;
    1[0-9]) icon="􀛪" color=$COLOR_ATTENTION_ICON ;;
    *)      icon="􀛪" color=$COLOR_DEFAULT_ICON ;;
esac

# if is charging
if ! [ -z "$charging" ]; then
    icon="􀢋"
fi

if [ "$(pgrep -x "caffeinate")" != "" ]; then
    icon="􀸙 ${icon}"
fi

sketchybar -m --set $NAME icon.color="$color"         \
                          icon="$icon"                \
                          label="${battery_percent}%"



