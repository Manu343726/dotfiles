#!/bin/bash

# Use colors, but only if connected to a terminal, and that terminal
# supports them. (From oh-my-zsh/tools/install.sh)
if which tput >/dev/null 2>&1; then
    ncolors=$(tput colors)
fi
if [ -t 1 ] && [ -n "$ncolors" ] && [ "$ncolors" -ge 8 ]; then
    RED="$(tput setaf 1)"
    GREEN="$(tput setaf 2)"
    YELLOW="$(tput setaf 3)"
    BLUE="$(tput setaf 4)"
    BOLD="$(tput bold)"
    NORMAL="$(tput sgr0)"
    MAGENTA=$(tput setaf 5)
    ORANGE=$(tput setaf 4)
    PURPLE=$(tput setaf 1)
    WHITE=$(tput setaf 7)
else
    RED=""
    GREEN=""
    YELLOW=""
    BLUE=""
    BOLD=""
    NORMAL=""
    MAGENTA=""
    ORANGE=""
    PURPLE=""
    WHITE=""
fi

print_message()
{
    local level=$1
    local category=$2
    local message="$3"
    local header=""
    local color=$NORMAL
    local bold=""

    if [[ "$level" == "TARGET" ]]; then
        header="==> "
        color=$GREEN
        bold=$BOLD
    elif [[ "$level" == "COMPONENT" ]]; then
        header="  -> "
        color=$BLUE
        bold=$BOLD
    elif [[ "$level" == "STEP" ]]; then
        header=""
        color=$NORMAL
        bold=""
    else
        header=""
        color=$NORMAL
        bold=""
    fi

    if [[ "$category" == "ERROR" ]]; then
        color=$RED
        header="${header}ERROR: "
    elif [[ "$category" == "WARNING" ]]; then
        color=$YELLOW
        header="${header}WARNING: "
    elif [[ "$category" == "NOTE" ]]; then
        color=$NORMAL
        header="${header}NOTE: "
    fi

    [[ "$level" == "TARGET"  ]] && echo ""
    echo ${color}${bold}${header}${NORMAL}${bold}${message}${NORMAL}
}

print_info()
{
    print_message "$1" "INFO" "$2"
}

print_note()
{
    print_message "$1" "NOTE" "$2"
}

print_warning()
{
    print_message "$1" "WARNING" "$2"
}

print_error()
{
    print_message "$1" "ERROR" "$2"
}