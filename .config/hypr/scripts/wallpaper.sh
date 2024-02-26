#!/bin/bash

DIR=~/.config/wallpapers
PICS=($(ls ${DIR}))

RANDOMPICS=${PICS[ $RANDOM % ${#PICS[@]} ]}

if [[ $(pidof swaybg) ]]; then
  pkill swaybg
fi

swww query || swww init

#change-wallpaper using swww
swww img ${DIR}/${RANDOMPICS} --transition-fps 60 --transition-type any --transition-duration 2

wal -i ~/.config/wallpapers
~/.config/.scripts/swww.sh

