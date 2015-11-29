#!/bin/bash
source setup.sh
source $DOTFILES_LIB/commands.sh
source $DOTFILES_LIB/package-management.sh

dotfiles_install()
{
    dotfiles_install_target terminal/zsh
    dotfiles_install_target terminal/appearance
    dotfiles_install_target editors/vim
    dotfiles_install_target editors/patata
}

dotfiles_install && echo Done!
