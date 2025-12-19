#!/bin/bash

# Set up everything for correct dotfile use
echo "This will overwrite a lot of stuff. You might want to back up your current configuration before continuing."
read -p "With that in mind, proceed? " -n 1 -r
if [[ ! $REPLY =~ ^[Yy]$ ]]
then
    exit 1
fi

which pacman && {
    if [ -x $(command -v paru) ]; then
        echo "Installing paru"
        sudo pacman -S --needed base-devel git
        git clone https://aur.archlinux.org/paru.git
        cd paru
        makepkg -si
    fi
    echo "Installing neovim"
    paru -S neovim
}

which apt && {
    echo "I will need superuser privileges to continue."
    sudo su
    echo "Installing neovim and zsh"
    apt install neovim zsh
}

echo "Installing oh-my-zsh (plugins and other functionality)"
RUNZSH=no sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
echo "Installing ohmyposh (terminal themeing)"
curl -s https://ohmyposh.dev/install.sh | bash -s
echo "Installing vim plug for Neovim"
sh -c 'curl -fLo "${XDG_DATA_HOME:-$HOME/.local/share}"/nvim/site/autoload/plug.vim --create-dirs \
       https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
echo "Installing Neovim plugins"
cp .config ~/
nvim -c PlugInstall +quitall
echo "Installing dotfiles"
cp asterisk.omp.json ~/
cp .zshrc ~/
cp .zsh_aliases ~/