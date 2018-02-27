#!/bin/bash

dotfiles_install_remote_component GITHUB junegunn/fzf fzf $HOME/.fzf
$HOME/.fzf/install

dotfiles_install_package ag
