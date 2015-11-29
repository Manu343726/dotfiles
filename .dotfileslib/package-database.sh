#!/bin/bash

export DOTFILES_PATH=$HOME/.dotfiles
export DOTFILES_PACKAGE_DATABASE=$DOTFILES_PATH/.dotfileslib/.package-database
export OPTPARSE_LIB=$DOTFILES_PATH/.dotfileslib/3rdParty/optparse

# The .package-database file stores entries (package name, distro) -> distro-specific package name
# as plain greppable text in the following format:
# 
#     PACKAGE_NAME DISTRO DISTRO_SPECIFIC_PACKAGE_NAME
#
# This script provides several commands to manipulate that database, such as adding new entries,
# deleting entries, searching for a package given the generic name and the current platform, etc

export DOTFILES_ERROR_NO_PACKAGE=1
export DOTFILES_ERROR_NO_DATABASE_FILE=2

source $OPTPARSE_LIB/optparse.bash

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

find_package()
{
    local generic_name="$1"
    local distro="$2"
    local regex="s/${generic_name} ${distro} *//p"

    local distro_specific_name=$(cat $DOTFILES_PACKAGE_DATABASE | sed -rn "$regex")

    if [ -n "$distro_specific_name" ]; then
        echo $distro_specific_name
        return 0
    else
        return $DOTFILES_ERROR_NO_PACKAGE
    fi
}

register_package()
{
    local generic_name="$1"
    local distro="$2"
    local name="$3"

    echo "${generic_name} ${distro} ${name}" >> $DOTFILES_PACKAGE_DATABASE
}



find_package_command()
{
    optparse.define short=g long=generic-name desc="Generic (distro-independent) package name" variable=package
    optparse.define short=d long=distro desc="Distro (arch, debian, etc)" variable=distro default=""
   
    source $( optparse.build )

    if [ -z "$package" ]; then
        echo "ERROR: No package specified"
        return 1
    fi

    if [ -z "$distro" ]; then
        distro=$(guess_distro)
    fi

    find_package "$package" "$distro"
}

register_package_command()
{
    optparse.define short=g long=generic-name desc="Generic (distro-independent) package name" variable=package
    optparse.define short=d long=distro desc="Distro (arch, debian, etc)" variable=distro default=""
    optparse.define short=n long=name desc="Distro-specific package name" variable=name
   
    source $( optparse.build )

    if [ -z "$package" ]; then
        echo "ERROR: No generic name given"
        return 1
    fi
    
    if [ -z "$name" ]; then
        echo "ERROR: No distro-specific name given"
        return 2
    fi
    
    if [ -z "$distro" ]; then
        distro=$(guess_distro)
    fi

    current_name=$(find_package "$package" "$distro")

    if [ -n "$current_name" ]; then
        echo "ERROR: Name '${package}' already registered in ${distro} as '${current_name}'"
        return 3
    fi

    register_package "$package" "$distro" "$name"
}

command="${1//-/_}_command"
shift
$command $@
