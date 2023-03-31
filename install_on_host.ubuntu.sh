#!/bin/bash

# Update the system
sudo apt-get update

# Install essentials
sudo apt-get install -y build-essential curl git exuberant-ctags software-properties-common gnupg locales unzip wget python3-pip virtualenv

# Install Neovim
sudo add-apt-repository -y ppa:neovim-ppa/unstable
sudo apt-get update
sudo apt-get install -y neovim
mkdir -p ~/.config/nvim/

# Install Node.js
curl -sL https://deb.nodesource.com/setup_14.x | sudo -E bash -
sudo apt-get install -y nodejs

# Configure environment variables
export PATH="/root/.local/bin:${PATH}"

# Copy configs
cp -rf ./configs/* ~/.config/nvim/
