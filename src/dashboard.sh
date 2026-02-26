#!/bin/bash

SOCKET=/tmp/dashboard-socket
rm -f $SOCKET

kitty --listen-on unix:/tmp/dashboard-socket -o enabled_layouts=splits -e btop &

for i in {1..20}; do
    sleep 0.3
    kitty @ --to unix:/tmp/dashboard-socket ls &>/dev/null && break
done

K="kitty @ --to unix:/tmp/dashboard-socket"

# First split: create right column (50/50)
$K launch --location vsplit --bias 50 cava

# Stack right column
$K launch --location hsplit --bias 66 tty-clock -c -S -s -n
$K launch --location hsplit --bias 50 terminal-rain

# Focus btop and hsplit for fastfetch with explicit config
$K focus-window --match "id:1"
sleep 0.2
$K launch --location hsplit --bias 40
