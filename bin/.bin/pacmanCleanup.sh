#!/bin/bash

# List explicitly installed packages
explicit_packages=$(pacman -Qe | awk '{print $1}')

# Display packages using fzf for selection
selected_packages=$(echo "$explicit_packages" | fzf --prompt="Select packages to delete: " --multi --preview-window=right:50% --preview='pacman -Qi {}')

# If no package selected, exit
if [ -z "$selected_packages" ]; then
    echo "No package selected."
    exit 0
fi

# Confirm deletion
echo "Selected packages to delete:"
echo "$selected_packages"
read -p "Are you sure you want to delete packages? (y/n): " confirm_delete

if [ "$confirm_delete" == "y" ]; then
    # Delete selected packages
    sudo pacman -Rns $selected_packages
    echo "Selected packages deleted."
else
    echo "Deletion aborted."
fi
