#!/usr/bin/env bash

source "$CONFIG_DIR/colors.sh"

percentage=$(pmset -g batt | grep -Eo '[0-9]+%' | head -1 | tr -d '%')
charging=$(pmset -g batt | grep 'AC Power')

if [ -z "$percentage" ]; then
  exit 0
fi

case "$percentage" in
  [8-9][0-9]|100)
    icon=""
    ;;
  7[0-9])
    icon=""
    ;;
  [4-6][0-9])
    icon=""
    ;;
  [1-3][0-9])
    icon=""
    ;;
  *)
    icon=""
    ;;
esac

if [ -n "$charging" ]; then
  icon=""
  color="$VIBRANT_GREEN"
elif [ "$percentage" -ge 80 ]; then
  color="$VIBRANT_GREEN"
elif [ "$percentage" -ge 40 ]; then
  color="$VIBRANT_ORANGE"
else
  color="$RED"
fi

sketchybar --set battery \
  icon="$icon" \
  label="${percentage}%" \
  icon.color="$color" \
  background.border_color="$color"
