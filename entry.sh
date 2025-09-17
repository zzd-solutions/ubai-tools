#!/bin/bash

REPO_URL="https://github.com/zzd-solutions/ubuntu-battery-script.git"
TARGET_DIR="ubuntu-battery-script"

# 1. Check if git is installed
if ! command -v git &> /dev/null; then
    echo "Git not found. Installing git..."
    # Only update the package index for git package
    sudo apt-get install -y git
else
    echo "Git is installed. Checking if upgrade is needed..."
    # Fast check if git can be upgraded
    UPGRADABLE=$(apt list --upgradable 2>/dev/null | grep -i "^git/")
    if [ -n "$UPGRADABLE" ]; then
        echo "Upgrading git..."
        sudo apt-get install --only-upgrade -y git
    else
        echo "Git is up to date."
    fi
fi

# 2. Clone or update repo
if [ -d "$TARGET_DIR/.git" ]; then
    echo "Repository already exists. Pulling latest changes..."
    cd "$TARGET_DIR"
    git pull
    cd ..
else
    echo "Cloning repository..."
    git clone "$REPO_URL"
fi

echo "Done."
