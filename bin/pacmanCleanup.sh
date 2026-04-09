#!/bin/bash

# List explicitly installed packages
explicit_packages=$(pacman -Qe | awk '{print $1}')
pacman_packages_file="$HOME/.dot/packages.txt"
aur_packages_file="$HOME/.dot/packages-aur.txt"

temp_file=$(mktemp)
sed -e '/^\s*#/d' -e '/^$/d' "$pacman_packages_file" > "$temp_file"
sed -e '/^\s*#/d' -e '/^$/d' "$aur_packages_file" >> "$temp_file"

# If the pacman packages file exists, get its content
if [ -f "$temp_file" ]; then
    saved_packages=$(<"$temp_file")
else
    saved_packages=""
fi

#echo "$saved_packages"

# Loop through each explicitly installed package
for package in $explicit_packages; do
    # Check if the package is not in the saved list
    if ! grep -q "^$package$" <<< "$saved_packages"; then
        new_packages+="$package\n"
        #echo "$package"
    fi
done


# Display packages using fzf for selection
selected_packages=$(printf "$new_packages" | fzf --prompt="Select packages to delete: " --multi --preview-window=right:50% --preview='pacman -Qi {}')

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
