#!/bin/bash

dotfiles_install_remote_component GITHUB tlatsas/xcolors xcolors
dotfiles_install_component .Xresources $HOME/.Xresources

export TERMINAL_APPEARANCE_THEME="autum"

THEMESDIR="${DOTFILES_CURRENT_SOURCE_DIR}/xcolors/themes"
#ln -s ${THEMESDIR}/${TERMINAL_APPEARANCE_THEME} ${DOTFILES_CURRENT_SOURCE_DIR}/selected-theme
# Update X configuration
xrdb -I$DOTFILES_CURRENT_SOURCE_DIR -I${THEMESDIR} -merge $HOME/.Xresources
