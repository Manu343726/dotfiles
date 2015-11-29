#!/bin/sh

guess_distro()
{
    if which pacman > /dev/null; then
        echo arch
        return 0
    elif which apt-get > dev/null; then
        echo debian
        return 0
    else
        return 1
    fi
}

translate_packages()
{
    local variable="$1"
    shift
    local specific_packages=""
    
    for generic_name in $@; do
        specific_package=$($DOTFILES_LIB/package-database.sh find-package --generic-name ${generic_name})

        if [ -z "$specific_package" ]; then
            if confirm_colored COMPONENT "No package is registered in this distro with name '${generic_name}'. Register now?"; then
                read -r -p "Enter the specific package name of '${generic_name}' in $(guess_distro): " specific_package
                $DOTFILES_LIB/package-database.sh register-package --generic-name ${generic_name} --name $specific_package
            else
                print_error COMPONENT "Could not translate package name '${generic_name}'" 
            fi
        fi

        specific_packages+=" ${specific_package}"
    done 

    # Return list of packages (filtering leading whitespace)
    specific_packages=$(echo -e "${specific_packages}" | sed -e 's/^[[:space:]]*//')
    print_info STEP "Packages translated to '${specific_packages}'"

    eval $variable="$specific_packages"
}

if which pacman > /dev/null; then
    export DOTFILES_PLATFORM="arch"
    source $DOTFILES_LIB/package-management/arch.sh
elif which apt-get > /dev/null; then
    export DOTFILES_PLATFORM="debian"
    source $DOTFILES_LIB/package-management/debian.sh
else
    print_error STEP "[Package Management] Unsupported platform"
fi
