# Path to your oh-my-zsh installation.
export DOTFILES=$HOME/.dotfiles
export ZSH=$HOME/.oh-my-zsh
export ZSH_FISH_COMPLETIONS=${DOTFILES}/terminal/zsh/fish-completions

# Set name of the theme to load.
# Look in ~/.oh-my-zsh/themes/
# Optionally, if you set this to "random", it'll load a random theme each
# time that oh-my-zsh is loaded.
ZSH_THEME="flazz"

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion. Case
# sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"

# Uncomment the following line to disable bi-weekly auto-update checks.
# DISABLE_AUTO_UPDATE="true"

# Uncomment the following line to change how often to auto-update (in days).
# export UPDATE_ZSH_DAYS=13

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# The optional three formats: "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# HIST_STAMPS="mm/dd/yyyy"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(git fbterm tmux timer)

# User configuration
# Enable 256 colors
[[ "$TERM" == "xterm" ]] && export TERM=xterm-256color
[[ "$TERM" == "screen" ]] && export TERM=screen-256color
export PATH="$PATH:/bin:/usr/local/sbin:/usr/local/bin:/usr/bin:/usr/bin/site_perl:/usr/bin/vendor_perl:/usr/bin/core_perl"
export PATH="$(ruby -e 'print Gem.user_dir')/bin:$PATH"
# export MANPATH="/usr/local/man:$MANPATH"

source $ZSH/oh-my-zsh.sh

export EDITOR=vim

if [ -z "$TMUX" ]
then
    tmux attach -t TMUX || tmux new -s TMUX
fi
# Load zsh-syntax-highlighting.
source ${ZSH_FISH_COMPLETIONS}/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

# Load zsh-autosuggestions.
source ${ZSH_FISH_COMPLETIONS}/zsh-autosuggestions/zsh-autosuggestions.zsh

export ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE='fg=5'

# You may need to manually set your language environment
# export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
# if [[ -n $SSH_CONNECTION ]]; then
#   export EDITOR='vim'
# else
#   export EDITOR='mvim'
# fi

# Compilation flags
# export ARCHFLAGS="-arch x86_64"

# ssh
# export SSH_KEY_PATH="~/.ssh/dsa_id"

# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.
#
# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"

# added by travis gem
[ -f /home/manu343726/.travis/travis.sh ] && source /home/manu343726/.travis/travis.sh

# Python 3.5
#alias python3.5=$HOME/Python-3.5.4/bin/python3.5
#alias pip3.5=$HOME/Python-3.5.4/bin/pip3.5

# keyboard shortcut to change between keyboard layouts (us, spanish)
setxkbmap -option grp:alt_shit_toggle us,es

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

bindkey "[D" backward-word
bindkey "[C" forward-word

alias 2048='$HOME/Documentos/2048-cli/2048'

# Default proto and Qt versions for wmip-whale dev:
export CMAKE_PREFIX_PATH="$HOME/Qt/5.9.2/gcc_64:/opt/protobuf-3.5.1:/opt/grpc"
export PATH=$PATH:$HOME/.cargo/bin

# Add jfrog cli to path
export PATH=$PATH:$HOME/jfrog
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh" # This loads nvm

alias cat=bat
alias ls=exa
