#!/usr/bin/env bash

MUTED=$(osascript -e "get volume settings" | grep "muted:true")

if [[ $INFO == "" ]]; then
    INFO=$(osascript -e "get volume settings" | cut -d " " -d ":" -f2 | cut -d "," -f1)
fi

if [[ $MUTED != "" ]]; then
ICON="􀊣"
else
case ${INFO} in
    100) ICON="􀊩";;
    9[0-9]) ICON="􀊩";;
    8[0-9]) ICON="􀊩";;
    7[0-9]) ICON="􀊧";;
    6[0-9]) ICON="􀊧";;
    5[0-9]) ICON="􀊧";;
    4[0-9]) ICON="􀊧";;
    3[0-9]) ICON="􀊧";;
    2[0-9]) ICON="􀊥";;
    1[0-9]) ICON="􀊥";;
    [0-9]) ICON="􀊥";;
    *) ICON="􀊡"
esac
fi

INFO=$(printf "%2s" $INFO)

sketchybar -m --set $NAME icon=$ICON \
              --set $NAME label="$INFO%"