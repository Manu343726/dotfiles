#!/bin/bash

export DOTFILES_VERBOSE_DISABLED=0
export DOTFILES_VERBOSE_LOW=1
export DOTFILES_VERBOSE_HIGH=2
export DOTFILES_VERBOSE_DEFAULT=$DOTFILES_VERBOSE_DISABLED

verbose_policy()
{
    source $OPTPARSE_LIB/optparse.bash
    optparse.define short=l long=message-level desc="Message source level (TARGET, COMPONENT, STEP)" variable=level
    source $(optparse.build)

    local declare -A policy=(
        ["${DOTFILES_VERBOSE_DISABLED}:TARGET"]=1
        ["${DOTFILES_VERBOSE_DISABLED}:COMPONENT"]=1
        ["${DOTFILES_VERBOSE_DISABLED}:STEP"]=1
        ["${DOTFILES_VERBOSE_LOW}:TARGET"]=1
        ["${DOTFILES_VERBOSE_LOW}:COMPONENT"]=1
        ["${DOTFILES_VERBOSE_LOW}:STEP"]=1
        ["${DOTFILES_VERBOSE_HIGH}:TARGET"]=1
        ["${DOTFILES_VERBOSE_HIGH}:COMPONENT"]=1
        ["${DOTFILES_VERBOSE_HIGH}:STEP"]=1)

    echo "$policy[${DOTFILES_VERBOSE_LEVEL}:$level]"
}
