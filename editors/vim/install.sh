#!/bin/bash

DOTVIM="${DOTFILES_CURRENT_SOURCE_DIR}/.vim"
BUNDLE="${DOTVIM}/bundle"

# Create .vim folder if needed
[ -d "$DOTVIM" ] && mkdir -p $DOTVIM

# Install vim with python support
dotfiles_install_package vim

# Install config
dotfiles_install_component .vim $HOME/.vim
dotfiles_install_component .vimrc $HOME/.vimrc

# Install vim vundle
dotfiles_install_remote_component GITHUB VundleVim/Vundle.vim ".vim/bundle/Vundle.vim"

# Install vim plugins
vim +PluginInstall +qall

# Use patched fzf.vim preview script to make previews
# in vim-bookmarks work
dotfiles_install_component fzf.vim-preview.sh $BUNDLE/fzf.vim/bin/preview.sh

# Build YouCompleteMe
if [[ -z $(find "${BUNDLE}/YouCompleteMe/third_party/ycmd" -name "libclang.*") ]]; then
    dotfiles_install_package cmake
    dotfiles_install_package libpython2
    dotfiles_install_package python2-dev
    print_info COMPONENT "Building YouCompleteMe.vim"
    python2 $BUNDLE/YouCompleteMe/install.py --clang-completer
else
    print_info COMPONENT "YouCompleteMe.vim already built"
fi
