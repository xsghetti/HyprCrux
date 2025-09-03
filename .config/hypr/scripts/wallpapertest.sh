#!/bin/bash

# Directory containing wallpapers
#!/bin/bash

WALLPAPER_DIR="$HOME/.config/wallpapers"
HYPERPAPER_CONFIG="$HOME/.config/hypr/hyprpaper.conf"

# Check if the directory exists
if [ ! -d "$WALLPAPER_DIR" ]; then
    echo "Wallpaper directory not found!"
    exit 1
fi

# Ensure Hyprpaper is running
if ! pgrep -x "hyprpaper" > /dev/null; then
    hyprpaper &
    sleep 0.5  # Give it some time to start
fi

# Function to format wallpapers for Rofi with previews
menu() {
    find "$WALLPAPER_DIR" -type f \( -iname "*.png" -o -iname "*.jpg" -o -iname "*.jpeg" -o -iname "*.gif" \) | while read -r img; do
        printf "$(basename "$img")\x00icon\x1f$img\n"
    done
}

# Show Rofi menu with image previews
WALLPAPER=$(menu | rofi -dmenu -theme $HOME/.config/rofi/themes/wallselect.rasi)

# Check if the user pressed Escape (Rofi returns 1 when Escape is pressed)
if [ $? -eq 1 ]; then
    echo "No wallpaper selected, exiting..."
    exit 0
fi

# If user selected a wallpaper, preload and set it using Hyprpaper
if [ -n "$WALLPAPER" ]; then
    FULL_PATH="$WALLPAPER_DIR/$WALLPAPER"

    # Check if the wallpaper file exists before applying it
    if [ -f "$FULL_PATH" ]; then
        # Preload the wallpaper
        hyprctl hyprpaper preload "$FULL_PATH"
        sleep 0.2  # Short delay to ensure it's loaded
        
        # Set the wallpaper using hyprpaper
        hyprctl hyprpaper wallpaper ", $FULL_PATH"

        # Update Hyprpaper config file to persist wallpaper after reboot
        echo "preload = $FULL_PATH" > "$HYPERPAPER_CONFIG"
        echo "wallpaper = , $FULL_PATH" >> "$HYPERPAPER_CONFIG"

        # Restart Hyprpaper to apply changes
        pkill hyprpaper
        hyprpaper &
        
        # Create symlink to the selected wallpaper for Rofi access
        ln -sf "$FULL_PATH" "$HOME/.config/rofi/.current_wallpaper"
        
        # Wait a moment to ensure the wallpaper is fully loaded before applying pywal
        sleep 1
        
        # Use pywal to generate color scheme from the current wallpaper
        wal -i "$FULL_PATH" --cols16
        sleep 1  # Wait a moment for pywal to finish executing
        
        # Run pywal-discord to update Discord (if applicable)
        pywal-discord
    else
        echo "Selected wallpaper file not found."
    fi
else
    echo "No wallpaper selected."
fi

# Kill any running Waybar process
pkill waybar

# Call a script to refresh Hyprpaper settings (if applicable)
~/.config/hypr/scripts/refresh.sh

# Relaunch waybar
waybar &

