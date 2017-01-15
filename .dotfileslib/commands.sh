#!/bin/bash

source $DOTFILES_LIB/printing.sh

download()
{
    local provider=$1
    local url=$2
    local dest=$3
    local path="${DOTFILES_CURRENT_SOURCE_DIR}/${dest}"

    print_info STEP "Downloading from $url to $path ($provider):"

    if [[ "$provider" == "GIT" ]]; then
        git clone $url $path
    elif [[ "$provider" == "GITHUB" ]]; then
        git clone "https://github.com/${url}" $path
    elif [[ "$provider" == "WGET" ]]; then
        wget -mirror -O $path $url
    elif [[ "$provider" == "CURL" ]]; then
        curl -o $path $url
    fi
}

dotfiles_install_remote_component()
{
    local provider=$1
    local component=$3
    local url=$2

    if [ "$#" -gt 3 ]; then
        dest=$4
    else
        dest=""
    fi

    path="${DOTFILES_CURRENT_SOURCE_DIR}/${component}"

    if [ -n "$dest" ]; then
        print_info COMPONENT "Installing remote component '$component' from '${url}' to $dest"
    else
        print_info COMPONENT "Getting remote component '$component' from '${url}'"
    fi 

    if [ ! -e "$path" -o ! -d "$path" ]; then
        download $provider "$url" "$component"
    else
        print_note STEP "Remote component '$component' already downloaded"
    fi

    if [ -n "$dest" ]; then
        print_note STEP "Download complete, installing to '${dest}'..."
        dotfiles_install_component "$component" "$dest"
    else
        print_note STEP "No destination specified, no install needed"
    fi

    local gitignore="${DOTFILES_CURRENT_SOURCE_DIR}/.gitignore"

    # Make git ignore remote components, so these are not pushed
    if ! ignore_entry=$(grep -lx "$component" -R "$gitignore"); then
        print_info STEP "Adding remote component '$component' to target .gitignore file..."
        echo $component >> $gitignore
    fi
}

dotfiles_install_component()
{
    local component="${DOTFILES_CURRENT_SOURCE_DIR}/$1"
    local dest="$2"
    local dest_backup=${dest}.pre-dotfiles

    if $DOTFILES_COMPONENT_CONFIRM; then
        confirm_colored COMPONENT "Proceed installing component '$1' as '$2'?" || return 0
    fi

    print_info COMPONENT "Installing component '$1' as '$2'"

    if [ ! -e "${component}" -a ! -L "${component}" ]; then
      print_error COMPONENT "No file or folder named '$1' in target source directory"
      return -1
    fi
    
    if [ -e "${dest}" ]; then

        print_warning STEP "Component $dest will be overwritten. Saved as ${dest_backup}"

        if [ -e "${dest_backup}" -o -L "${dest_backup}" ]; then
            previous_backup=${dest_backup}.old.$(date "+%Y-%m-%d.%H:%M:%S")            
            print_warning STEP "Detected previous backup file/folder at '${dest_backup}'. Saved as '${previous_backup}'"
            mv $dest_backup $previous_backup
        fi

        if [ -h "${dest}" ]; then
            ln -s $(readlink $dest) ${dest_backup}
            rm $dest
        else
            mv $dest ${dest_backup}
        fi
    fi

    ln -s $component $dest
}

dotfiles_install_target()
{
    export DOTFILES_CURRENT_SOURCE_DIR="${DOTFILES_SRC_DIR}/$1"

    if $DOTFILES_TARGET_CONFIRM; then
        confirm_colored TARGET "Proceed installing target '$1'?" || return 0
    fi
    
    if [ ! -d "$DOTFILES_CURRENT_SOURCE_DIR" ]; then
        print_error TARGET "Target '$1' does not exist. Skipping..."
    else
        if [ ! -f "${DOTFILES_CURRENT_SOURCE_DIR}/install.sh" ]; then
          print_error TARGET "Missing install.sh file for target '$1', skipping..."
        else
          print_info TARGET "Installing target $1..."

          source ${DOTFILES_CURRENT_SOURCE_DIR}/install.sh
        fi
    fi
}
