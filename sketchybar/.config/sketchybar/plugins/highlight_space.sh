#!/usr/bin/env bash

workspace_ids=( $(aerospace list-workspaces --all 2>/dev/null || aerospace list-workspaces) )
focused="${FOCUSED_WORKSPACE}"

if [ -z "$focused" ]; then
  focused="$(aerospace list-workspaces --focused 2>/dev/null)"
fi

count=${#workspace_ids[@]}
if [ "$count" -eq 0 ]; then
  exit 0
fi

index=1
for wid in "${workspace_ids[@]}"; do
  if [ "$wid" = "$focused" ]; then
    break
  fi
  index=$((index + 1))
done

if [ "$index" -gt "$count" ]; then
  index=1
fi

padding=$((-(count - (index - 1)) * 30 + 7))

sketchybar --animate circ 15 --set highlight_space background.padding_left="$padding"
