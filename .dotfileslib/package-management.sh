#!/bin/sh

source $DOTFILES_LIB/guess-distro.sh

translate_packages()
{
    local variable="$1"
    shift
    local specific_packages=""
    
    for generic_name in $@; do
        specific_package=$($DOTFILES_LIB/package-database.sh find-package --generic-name ${generic_name})

        if [ -z "$specific_package" ]; then
            if confirm_colored COMPONENT "No package is registered in this distro with name '${generic_name}'. Register now?"; then
                read -r -p "Enter the specific package name of '${generic_name}' in ${DOTFILES_PLATFORM}: " specific_package
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

export DOTFILES_PLATFORM=$(guess_distro)
export DOTFILES_PACKAGE_MANAGER=$DOTFILES_LIB/package-management/${DOTFILES_PLATFORM}.sh

if [ -z "$DOTFILES_PLATFORM" ]; then
    print_error TARGET "[Package management] Unknown platform"
    exit 1
fi

if [ ! -f "$DOTFILES_PACKAGE_MANAGER" ]; then
    print_error TARGET "[Package management] No package manager file found. Expected ${DOTFILES_PACKAGE_MANAGER}"
    exit 2
fi

source ${DOTFILES_LIB}/package-management/${DOTFILES_PLATFORM}.sh

alias dotfiles_install_package='install_package'
alias dotfiles_update_system='update_system'
