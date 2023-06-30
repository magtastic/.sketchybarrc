case "$(/usr/local/bin/xkbswitch -ge)" in
    "ABC")
      label="EN"
      ;;
    "Icelandic")
      label="ÍS"
      ;;
esac

sketchybar --set $NAME label=$label
