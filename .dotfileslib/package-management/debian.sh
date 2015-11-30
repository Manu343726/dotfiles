#!/bin/bash

if $DOTFILES_NOCONFIRM; then
    export NOCONFIRM="-y"
else
    export NOCONFIRM=""
fi

install_package()
{
    print_info COMPONENT "Installing packages '${@}'..."

    translate_packages packages $@

    if [ -n "$packages" ]; then
        sudo apt-get install "${packages}" $NOCONFIRM 
    fi
}

update_system()
{
    print_info COMPONENT "Updating system..."
    
    sudo apt-get update $NOCONFIRM
    sudo apt-get upgrade $NOCONFIRM
}
