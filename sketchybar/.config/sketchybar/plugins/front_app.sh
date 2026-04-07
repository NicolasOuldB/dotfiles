#!/usr/bin/env bash

if [ -n "$INFO" ]; then
  sketchybar --set "$NAME" label="$INFO"
else
  sketchybar --set "$NAME" label="Desktop"
fi
