#!/usr/bin/env bash

label="$INFO"
if [ -z "$label" ]; then
  label="$(osascript -e 'tell application "System Events" to get name of first process whose frontmost is true' 2>/dev/null)"
fi

if [ -z "$label" ]; then
  label="Desktop"
fi

first_char="$(printf '%s' "$label" | cut -c1)"
rest="${label#?}"
first_char="$(printf '%s' "$first_char" | tr '[:lower:]' '[:upper:]')"
label="${first_char}${rest}"

sketchybar --set title label="$label"
