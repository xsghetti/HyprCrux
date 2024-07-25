#!/bin/bash

# Function to get current gaps_out
get_current_gaps_out() {
    hyprctl getoption general:gaps_out -j | jq -r '.custom' | awk '{print $1}'
}

# Function to set new gaps_out
set_new_gaps_out() {
    hyprctl keyword general:gaps_out $1
}

# Check if an argument is provided
if [ $# -eq 0 ]; then
    echo "Usage: $0 [up|down]"
    exit 1
fi

# Get the current gaps_out
current_gaps=$(get_current_gaps_out)

# If current_gaps is empty or not a number, set it to 0
if ! [[ "$current_gaps" =~ ^[0-9]+$ ]] ; then
    current_gaps=0
fi

# Adjust gaps based on argument
case $1 in
    "up")
        new_gaps=$((current_gaps + 10))
        ;;
    "down")
        new_gaps=$((current_gaps - 10))
        ;;
    *)
        echo "Invalid argument. Use up or down"
        exit 1
        ;;
esac

# Ensure gaps don't go negative
if [ $new_gaps -lt 0 ]; then
    new_gaps=0
fi

# Set the new gaps_out
set_new_gaps_out $new_gaps

echo "Gaps_out changed from $current_gaps to $new_gaps"

