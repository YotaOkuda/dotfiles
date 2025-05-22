#!/bin/bash

battery=(
  script="$PLUGIN_DIR/battery.sh"
  icon.font="$FONT:Regular:19.0"
  icon.padding_right=5
  padding_right=5
  padding_left=0
  # label.drawing=off
  update_freq=120
  updates=on
)

sketchybar --add item battery right \
  --set battery "${battery[@]}" \
  --subscribe battery system_woke power_source_change \

