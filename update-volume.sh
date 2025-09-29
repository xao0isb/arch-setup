#!/bin/bash

action=$1

if [[ $action == toggle ]]; then
  pactl set-sink-mute @DEFAULT_SINK@ toggle
else
  mute_status=$(pactl get-sink-mute @DEFAULT_SINK@)
  if [[ "$mute_status" == *"Mute: yes"* ]]; then
    pactl set-sink-mute @DEFAULT_SINK@ toggle
  fi

  volume_info=$(pactl get-sink-volume @DEFAULT_SINK@)
  volume=$(echo "$volume_info" | grep -oP 'Volume:.*?\K\d+%' | head -1 | grep -oP '\d+')
  if [[ ${action:0:1} == + && $volume -ge 100 ]]; then
    : # Do nothing
  else
    pactl set-sink-volume @DEFAULT_SINK@ $action
  fi
fi

volume_info=$(pactl get-sink-volume @DEFAULT_SINK@)
volume=$(echo "$volume_info" | grep -oP 'Volume:.*?\K\d+%' | head -1 | grep -oP '\d+')

mute_status=$(pactl get-sink-mute @DEFAULT_SINK@)
echo $mute_status
if [[ "$mute_status" == *"Mute: yes"* ]]; then
  volume=0
fi
echo $volume

dunstify -a "changeVolume" -h string:x-dunst-stack-tag:volume -h int:value:"$volume" -h string:hlcolor:#ffffff ""
