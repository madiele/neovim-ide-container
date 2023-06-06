#!/bin/bash

# Update the system
sudo dnf update

# Install essentials
sudo dnf install -y build-essential curl git exuberant-ctags software-properties-common gnupg locales unzip wget python3-pip virtualenv

# Install Neovim
dnf copr enable agriffis/neovim-nightly
sudo dnf install -y neovim python3-neovim

# Install Node.js
sudo dnf install -y nodejs

# Copy configs
mkdir -p ~/.config/nvim/
cp -rf ./configs/* ~/.config/nvim/
