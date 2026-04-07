#!/usr/bin/env bash

source "$CONFIG_DIR/colors.sh"

sid="${NAME#space.}"

focused="${FOCUSED_WORKSPACE}"
if [ -z "$focused" ]; then
  focused="$(aerospace list-workspaces --focused 2>/dev/null)"
fi

if [ "$sid" = "$focused" ]; then
  sketchybar --set "$NAME" \
    icon.color=$LABEL \
    background.drawing=on \
    background.color=$BLUE
else
  sketchybar --set "$NAME" \
    icon.color=$LABEL \
    background.drawing=off
fi
