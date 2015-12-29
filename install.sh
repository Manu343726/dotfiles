#!/bin/bash

export DOTFILES_SRC_DIR=$HOME/.dotfiles
export DOTFILES_URL=https://github.com/Manu343726/dotfiles
export DOTFILES_LIB=$DOTFILES_SRC_DIR/.dotfileslib
export OPTPARSE_LIB=$DOTFILES_LIB/3rdParty/optparse

if [ ! -d "$DOTFILES_SRC_DIR" ]; then
    git clone $DOTFILES_URL $DOTFILES_SRC_DIR
fi

if [ ! -d "$OPTPARSE_LIB" -o "$(ls -A $OPTPARSE_LIB 2> /dev/null)" == "" ]; then
    current=$(pwd)
    cd $DOTFILES_SRC_DIR
    git submodule update --init
    cd $current
fi

source $DOTFILES_LIB/verbosity.sh
source $OPTPARSE_LIB/optparse.bash

# Install options
optparse.define short=u long=update desc="Update repo before installing" variable=update default=false value=true
optparse.define short=v long=verbosity desc="verbose output level (Disabled=0, Low=1, High=2)" variable=verbosity default=$DOTFILES_VERBOSE_DEFAULT
optparse.define short=a long=target-confirm desc="Asks before installing a target, so you can select which targets to install while running" variable=target_confirm value=true default=false
optparse.define short=o long=component-confirm desc="Same as 'target-confirm', but for components. Implies low verbosity" variable=component_confirm value=true default=false
optparse.define short=n long=noconfirm desc="No confirmation flag is passed to commands where it's supported, such as package managers" variable=noconfirm value=true default=false
optparse.define short=t long=target desc="Ignores root install.sh and installs the specified target" variable=target default=""
source $(optparse.build)

if $component_confirm && [ "$verbosity" == "$DOTFILES_VERBOSE_DISABLED" ]; then
    echo NOTE: Verbosity raised to level ${DOTFILES_VERBOSE_LOW} by --component-confirm flag

    verbosity=$DOTFILES_VERBOSE_LOW
fi

if $update; then
   current=$(pwd)
   git pull
   git submodule foreach git pull
   cd $current
fi

export DOTFILES_VERBOSE_LEVEL=$verbosity
export DOTFILES_TARGET_CONFIRM=$target_confirm
export DOTFILES_COMPONENT_CONFIRM=$component_confirm
export DOTFILES_NOCONFIRM=$noconfirm

source $DOTFILES_LIB/commands.sh
source $DOTFILES_LIB/package-management.sh

if [[ -n "$target" ]]; then
    dotfiles_install_target "$target" && echo Done!
    exit $?
fi

dotfiles_install()
{
    dotfiles_install_target terminal/zsh
    dotfiles_install_target terminal/appearance
    dotfiles_install_target editors/vim
    dotfiles_install_target editors/patata
    dotfiles_install_target i3
}

dotfiles_install && echo Done!
