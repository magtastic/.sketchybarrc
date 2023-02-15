#!/usr/bin/env bash

if [ "$(pgrep -x "caffeinate")" = "" ]; then
    caffeinate -id &disown;
else
    killall caffeinate
fi

sketchybar -m --trigger caffeinate