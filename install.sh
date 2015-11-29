#!/bin/bash

export DOTFILES_SRC_DIR=$HOME/.dotfiles
export DOTFILES_URL=https://github.com/Manu343726/dotfiles
export DOTFILES_LIB=$DOTFILES_SRC_DIR/.dotfileslib
export OPTPARSE_LIB=$DOTFILES_LIB/3rdParty/optparse

if [ ! -d "$DOTFILES_SRC_DIR" ]; then
    git clone $DOTFILES_URL $DOTFILES_SRC_DIR
    pushd $DOTFILES_SRC_DIR && git submodule update --init && popd
fi

source $OPTPARSE_LIB/optparse.bash
# Install options
optparse.define short=v long=verbose desc="verbose output" variable=DOTFILES_VERBOSE default=false
source $(optparse.build)


source $DOTFILES_LIB/commands.sh

dotfiles_install()
{
    dotfiles_install_target terminal/zsh
    dotfiles_install_target terminal/appearance
    dotfiles_install_target editors/vim
    dotfiles_install_target editors/patata
}

dotfiles_install && echo Done!
