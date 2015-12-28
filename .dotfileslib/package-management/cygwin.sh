#!/bin/bash

install_package()
{
    print_info COMPONENT "Installing packages '${@}'..."

    translate_packages packages $@

    if [ -n "$packages" ]; then
        apt-cyg install "${packages}" $NOCONFIRM 
    fi
}

update_system()
{
    print_info COMPONENT "Updating system..."
    
    sudo apt-cyg update
}
