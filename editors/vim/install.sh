#!/bin/bash

# Create .vim folder if needed
[ -d ".vim" ] && mkdir -p .vim

# Install vim vundle
dotfiles_install_remote_component GITHUB VundleVim/Vundle.vim .vim/bundle/Vundle.vim

# Install config
dotfiles_install_component .vim $HOME/.vim
dotfiles_install_component .vimrc $HOME/.vimrc