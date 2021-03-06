#!/bin/bash

# Script for installing and setting up dotfiles
# Usage: wget https://raw.githubusercontent.com/proshanto/dotfiles/master/setup.sh -O setup.sh; chmod +x setup.sh; ./setup.sh
# or     curl -L https://raw.githubusercontent.com/proshanto/dotfiles/master/setup.sh > setup.sh; chmod +x setup.sh; ./setup.sh

# Update package list
sudo apt-get update

# Create a profile for gnome terminal

# If GNOME configuration database system is not available then install
gconf=$(dpkg --get-selections | grep gconf2)
if [ -z "$gconf" ]; then
    sudo apt-get install -y gconf2
fi

wget https://raw.githubusercontent.com/chriskempson/tomorrow-theme/master/Gnome-Terminal/setup-theme.sh -O - | bash

# Install vim and setup

sudo apt-get install -y vim git

# Install Vim Pathogen
mkdir -p ~/.vim/autoload ~/.vim/bundle && \
wget https://tpo.pe/pathogen.vim -O ~/.vim/autoload/pathogen.vim

# Install NerdTree
cd ~/.vim/bundle
git clone https://github.com/scrooloose/nerdtree.git

# Install lucius color scheme for vim
mkdir -p ~/.vim/colors # Create directory if it's not already created
wget "http://www.vim.org/scripts/download_script.php?src_id=23000" -O ~/.vim/colors/lucius.vim

# Install zsh
sudo apt-get install -y zsh
wget https://raw.github.com/robbyrussell/oh-my-zsh/master/tools/install.sh -O - | sh

# Backup existing files
timestamp=`date +%Y-%m-%d_%H:%M:%S`

if [ -f ~/.bashrc ]; then
    echo -e "Found ~/.bashrc. Backing up to ~/.bashrc.${timestamp}\n";
    mv ~/.bashrc ~/.bashrc.${timestamp};
fi

if [ -f ~/.zshrc ]; then
    echo -e "Found ~/.zshrc. Backing up to ~/.zshrc.${timestamp}\n";
    mv ~/.zshrc ~/.zshrc.${timestamp};
fi

if [ -f ~/.vimrc ]; then
    echo -e "Found ~/.vimrc. Backing up to ~/.vimrc.${timestamp}\n";
    mv ~/.vimrc ~/.vimrc.${timestamp};
fi

if [ -f ~/.gitconfig ]; then
    echo -e "Found ~/.gitconfig. Backing up to ~/.gitconfig.${timestamp}\n";
    mv ~/.gitconfig ~/.gitconfig.${timestamp};
fi


# download and overwrite files if already exists

# bash
wget https://raw.githubusercontent.com/proshanto/dotfiles/master/.aliases -O ~/.aliases
wget https://raw.githubusercontent.com/proshanto/dotfiles/master/.alias_functions -O ~/.alias_functions
wget https://raw.githubusercontent.com/proshanto/dotfiles/master/.bashrc -O ~/.bashrc

# git
wget https://raw.githubusercontent.com/proshanto/dotfiles/master/.gitconfig -O ~/.gitconfig

# vim
wget https://raw.githubusercontent.com/proshanto/dotfiles/master/.vimrc -O ~/.vimrc

# zsh
wget https://raw.githubusercontent.com/proshanto/dotfiles/master/.zshrc -O ~/.zshrc

# Create a file for local aliases
touch ~/.aliases_local