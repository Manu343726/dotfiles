#!/bin/bash

export DOTFILES_SRC_DIR=$HOME/.dotfiles
export DOTFILES_URL=https://github.com/Manu343726/dotfiles

if [ ! -d "$DOTFILES_SRC_DIR" ]; then
	git clone $DOTFILES_URL $DOTFILES_SRC_DIR
fi

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
		header=" -> "
		color=$BLUE
		bold=$BOLD
	elif [[ "$level" == "STEP" ]]; then
		header="> "
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
		color=$MAGENTA
		header="${header}NOTE: "
	fi

	echo "${color}${bold}${header}${NORMAL}${bold}${message}${NORMAL}"
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

	if [ "$#" -gt 4 ]; then
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

    print_info COMPONENT "Installing component '$1' as '$2'"

	if [ ! -e "${component}" -a ! -L "${component}" ]; then
      print_error COMPONENT "No file or folder named '$1' in target source directory"
      return -1
    fi
    
    if [ -e "${dest}" ]; then

    	print_warning STEP "Component $dest will be overwritten. Saved as ${dest_backup}"

    	if [ -e "${dest_backup}" -o -L "${dest_backup}" ]; then
    		rm $dest_backup
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

dotfiles_install()
{
	dotfiles_install_target terminal/zsh
	dotfiles_install_target terminal/appearance
	dotfiles_install_target editors/vim
	dotfiles_install_target editors/patata
}

dotfiles_install && echo Done!