#!/bin/bash

DOTVIM="${DOTFILES_CURRENT_SOURCE_DIR}/.vim"
BUNDLE="${DOTVIM}/bundle"

# Create .vim folder if needed
[ -d "$DOTVIM" ] && mkdir -p $DOTVIM

# Install neovim and vim (Just for the case)
dotfiles_install_package neovim vim

# Install config
dotfiles_install_component .vim $HOME/.vim
dotfiles_install_component .vimrc $HOME/.vimrc

# Alias neovim config to vim config
mkdir -p ${XDG_CONFIG_HOME:=$HOME/.config}
ln -s $HOME/.vim ${XDG_CONFIG_HOME}/nvim
ln -s $HOME/.vimrc ${XDG_CONFIG_HOME}/nvim/init.vim
sudo pip install nvim

# Install vim vundle
dotfiles_install_remote_component GITHUB VundleVim/Vundle.vim ".vim/bundle/Vundle.vim"

# Install vim plugins
vim +PluginInstall +qall

# Build YouCompleteMe
if [[ -z $(find "${BUNDLE}/YouCompleteMe/third_party/ycmd" -name "libclang.*") ]]; then
    dotfiles_install_package cmake
    print_info COMPONENT "Building YouCompleteMe.vim"
    python2 $BUNDLE/YouCompleteMe/install.py --clang-completer
else
    print_info COMPONENT "YouCompleteMe.vim already built"
fi
