#!/bin/bash

REPO_URL="https://github.com/zzd-solutions/ubai-tools.git"

# Function to install or update a branch
install_branch() {
    local BRANCH="$1"
    local TARGET_DIR="${BRANCH}_izot_tools"

    echo "Processing branch '$BRANCH' into directory '$TARGET_DIR'..."

    # Check if Git is installed
    if ! command -v git &> /dev/null; then
        echo "Git not found. Installing git..."
        sudo apt-get install -y git
    else
        echo "Git is installed. Checking if upgrade is needed..."
        UPGRADABLE=$(apt list --upgradable 2>/dev/null | grep -i "^git/")
        if [ -n "$UPGRADABLE" ]; then
            echo "Upgrading git..."
            sudo apt-get install --only-upgrade -y git
        else
            echo "Git is up to date."
        fi
    fi

    # Clone or update the repository
    if [ -d "$TARGET_DIR/.git" ]; then
        echo "Repository already exists. Forcing update..."
        cd "$TARGET_DIR"
        git fetch --all
        git reset --hard "origin/$BRANCH"
        cd ..
    else
        echo "Cloning repository..."
        git clone --branch "$BRANCH" "$REPO_URL" "$TARGET_DIR"
    fi

    echo "Branch '$BRANCH' is ready in '$TARGET_DIR'."
}

# Always install/update both branches
install_branch "main"
install_branch "dev"

echo "Both branches installed/updated successfully."

# Copy entry.sh and install.sh safely (overwrite if exists)
cp -f ./main_izot_tools/entry.sh ./b
cp -f ./main_izot_tools/install.sh ./install.sh
chmod +x ./b
chmod +x ./install.sh

# Run entry script
bash ./b
