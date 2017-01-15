#!/bin/bash

dotfiles_install_package zsh
dotfiles_install_package ruby
dotfiles_install_package tmux
# Install oh-my-zsh
sh -c "$(curl -fsSL https://raw.github.com/robbyrussell/oh-my-zsh/master/tools/install.sh)" || true

# Install fishshell completions
dotfiles_install_remote_component GITHUB tarruda/zsh-autosuggestions fish-completions/zsh-autosuggestions $HOME/.oh-my-zsh/custom/plugins/zsh-autosuggestions
dotfiles_install_remote_component GITHUB jimmijj/zsh-syntax-highlighting fish-completions/zsh-syntax-highlighting $HOME/.oh-my-zsh/custom/plugins/zsh-syntax-highlighting

# Install config
dotfiles_install_component .zshrc $HOME/.zshrc
