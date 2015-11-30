#!/bin/bash

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
