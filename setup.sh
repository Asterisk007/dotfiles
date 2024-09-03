#!/bin/bash

# Set up everything for correct dotfile use
echo "This will overwrite a lot of stuff. You might want to back up your current configuration before continuing."
read -p "With that in mind, proceed? " -n 1 -r
if [[ ! $REPLY =~ ^[Yy]$ ]]
then
    exit 1
fi

if [[ $(which paru) == "" ]]
then
    echo "Installing paru"
    sudo pacman -S --needed base-devel git
    git clone https://aur.archlinux.org/paru.git
    cd paru
    makepkg -si
fi

cd ~
echo "Installing neovim"
paru -S neovim
