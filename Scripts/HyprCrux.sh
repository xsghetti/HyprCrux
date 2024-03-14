#!/bin/bash

# Check if dotfiles directory exists
if [ ! -d ~/dotfiles ]; then
    echo "Dotfiles directory not found. Please clone the repository manually."
    exit 1
fi

# Copy .config folders from ~/.config to dotfiles repository
cp -r ~/.config/* ~/dotfiles/.config/

# Check if the copy was successful
if [ $? -ne 0 ]; then
    echo "Failed to copy .config folders to dotfiles repository. Exiting."
    exit 1
fi

echo ".config folders copied to dotfiles repository successfully."

# Copy .config folders to ~/.config
cp -r ~/dotfiles/.config/* ~/.config/

# Check if the copy was successful
if [ $? -ne 0 ]; then
    echo "Failed to copy .config folders. Exiting."
    exit 1
fi

echo "Dotfiles .config folders copied successfully."

# Define the directories containing the scripts
hypr_script_dir="$HOME/.config/hypr/scripts"
dotfiles_script_dir="$HOME/dotfiles/Scripts"

# Function to make scripts executable
make_executable() {
    local dir=$1

    # Check if the directory exists
    if [ -d "$dir" ]; then
        # Change directory to the specified directory
        cd "$dir" || exit

        # Loop through each file in the directory
        for file in *; do
            # Check if the file is a regular file and not a directory
            if [ -f "$file" ]; then
                # Make the file executable
                chmod +x "$file"
                echo "Made $file executable."
            fi
        done
    else
        echo "Directory $dir does not exist."
    fi
}

# Make scripts in ~/.config/hypr/scripts executable
make_executable "$hypr_script_dir"

# Make scripts in ~/dotfiles/Scripts executable
make_executable "$dotfiles_script_dir"
