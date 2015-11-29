#!/bin/bash

if $DOTFILES_NOCONFIRM; then
    export NOCONFIRM="--noconfirm"
else
    export NOCONFIRM=""
fi

install_package()
{
    print_info COMPONENT "Installing packages '${@}'..."

    translate_packages packages $@

    if [ -n "$packages" ]; then
        sudo pacman -S "${packages}" $NOCONFIRM --needed || (which yaourt > /dev/null && yaourt -S "${packages}" $NOCONFIRM --needed)
    fi
}

update_system()
{
    print_info COMPONENT "Updating system..."

    (which yaourt > /dev/null && yaourt -Syua $NOCONFIRM) || sudo pacman -Syua $NOCONFIRM
}
