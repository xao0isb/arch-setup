#!/bin/bash

max_brightness=$(cat /sys/class/backlight/amdgpu_bl1/max_brightness)
current_value=$(cat /sys/class/backlight/amdgpu_bl1/brightness)

user_value=$1
action=${user_value:0:1}
number=${user_value:1:2}

number_percent=$(echo "scale=2; $number / 100" | bc)
number=$(echo "scale=0; $max_brightness * $number_percent / 1" | bc)

if [ $action == "-" ]; then
  set_value=$((current_value - number))
elif [ $action == "+" ]; then
  set_value=$((current_value + number))
fi

if [ $set_value -lt 0 ]; then
  set_value=0
elif [ $set_value -gt $max_brightness ]; then
  set_value=$max_brightness
fi

echo $set_value | sudo tee -a /sys/class/backlight/amdgpu_bl1/brightness

set_value_percent=$(echo "scale=2; $set_value / $max_brightness * 100" | bc)
dunstify -a "changeBrightness" -h string:x-dunst-stack-tag:brightness -h int:value:"$set_value_percent" -h string:hlcolor:#ffffff ""
