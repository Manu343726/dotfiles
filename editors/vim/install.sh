#!/bin/bash

DOTVIM="${DOTFILES_CURRENT_SOURCE_DIR}/.vim"
BUNDLE="${DOTVIM}/bundle"

# Create .vim folder if needed
[ -d "$DOTVIM" ] && mkdir -p $DOTVIM

# Install vim vundle
dotfiles_install_remote_component GITHUB VundleVim/Vundle.vim ".vim/bundle/Vundle.vim"

# Install vim plugins
vim +PluginInstall +qall

# Install config
dotfiles_install_component .vim $HOME/.vim
dotfiles_install_component .vimrc $HOME/.vimrc

# Build YouCompleteMe
if [[ -z $(find "${BUNDLE}/YouCompleteMe/third_party/ycmd" -name "libclang.*") ]]; then
    print_info COMPONENT "Building YouCompleteMe.vim"
    python2 $BUNDLE/YouCompleteMe/install.py --clang-completer
else
    print_info COMPONENT "YouCompleteMe.vim already built"
fi
