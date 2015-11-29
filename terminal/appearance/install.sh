#!/bin/bash

dotfiles_install_remote_component GITHUB tlatsas/xcolors xcolors
dotfiles_install_component .Xresources $HOME/.Xresources

# Update X configuration
xrdb -merge $HOME/.Xresources
