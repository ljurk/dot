#!/bin/bash

# Get explicitly installed packages
explicit_packages=$(pacman -Qqe)

echo "Explicitly installed packages and their dependencies:"

# Loop through each package
for package in $explicit_packages; do
    # Get dependencies count
    dependencies=$(pacman -Qi "$package" | awk '/Depends On/ {print}' | wc -w)
    echo "$dependencies: $package"
done
