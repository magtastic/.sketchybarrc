#!/usr/bin/env bash

NUMBER="$(echo $NAME|awk -F. '{print $NF}')"
SPACE_ICONS=("􀀺" "􀀼" "􀀾" "􀁀" "􀁂" "􀁄" "􀁆" "􀁈" "􀁊" "􀓵" "􀓶" "􀓷" "􀓸")
SELECTED_SPACE_ICONS=("􀀻" "􀀽" "􀀿" "􀁁" "􀁃" "􀁅" "􀁇" "􀁉" "􀁋" "􀔔" "􀔕" "􀔖" "􀔗")

if [[ "$SELECTED" == "true" ]]
then
  ICON=${SELECTED_SPACE_ICONS[$(($NUMBER-1))]}
else
  ICON=${SPACE_ICONS[$(($NUMBER-1))]}
fi

sketchybar -m --set ${NAME} icon="$ICON" icon.highlight=${SELECTED} background.drawing=${SELECTED}
