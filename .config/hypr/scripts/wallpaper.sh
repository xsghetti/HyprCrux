#!/bin/bash

DIR=~/.config/wallpapers
PICS=($(ls ${DIR}))

RANDOMPICS=${PICS[ $RANDOM % ${#PICS[@]} ]}

if [[ $(pidof swww) ]]; then
  pkill swww
fi

swww query || swww init

#change-wallpaper using swww
swww img ${DIR}/${RANDOMPICS} --transition-fps 60 --transition-type any --transition-duration 2

wal -i ~/.config/rofi/.current_wallpaper

~/.config/.scripts/swww.sh

_ps=(waybar)
for _prs in "${_ps[@]}"; do
    if pidof "${_prs}" >/dev/null; then
        pkill "${_prs}"
    fi
done

sleep 1
# Relaunch waybar
waybar &

