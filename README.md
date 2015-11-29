# Dotfiles

My personal dotfiles repository

# Install

Just run `install.sh`, it takes care of everything

# Philosophy

The idea of this repo is to have a declarative way to manage configuration bootstrapping. I hate setting up terminals, editors, etc with the fancy schemes and tools I like, so I tried to automate as more as possible.

To make version control of configuration simple and painless, all configuration is placed in your `$HOME/.dotfiles` directory. Then all different scripts, directories etc are symlinked from their usual locations to their `.dotfiles` counterparts.

## Targets and components

Targets are the different subsystems you are targetting with this config, say X windows, text editors, IDEs, terminals, etc.  
Each target is identified as a directory with its own `install.sh` script which declares how that target should be installed. In the main `install.sh`, invoke the `dotfiles_install_target` command to install the targets you want.

Also targets can have different components, which are the configuration entities (folders, scripts, etc) you manage. Take vim as an example: You can have an `editors/vim` target which takes care of your `.vimrc` file and `.vim/` directory. Don't forget to 

## Installing

Using the `install.sh` file you can specify custom commands you need to bootstrap a target and its components (Install your favourite shell, update your system, etc), but also you have to take care of the location of that components.

Since configuration files live in `.dotfiles` target directories, you have to *install* these files into your system. That is, to create symbolic links from the expected script/directory path (Say `$HOME/.vimrc`) to their path inside `.dotfiles.` ($HOME/.dotfiles/editors/vim/.vimrc` for example).

Don't worry, hopefully we have a bunch of commands to automate this:

 - **`dotfiles_install_component <component> <full destination path>`**: Installs the component `<component>` of the current target as the specified path.

 - **`dotfiles_install_remote_component <provider> <url> <component> [<install path>]`**: Pulls a `<component>` from a remote `<url>` using the specified `<provider>`. A *provider* is just the way the component is downloaded, currently `GIT`, `GITHUB` (Same as git but assumes Github URL), `WGET`, and `CURL`. Optionally, you can pass `<install path>` to also install the component.
 Note that remote components are meant to be pulled, so they are ignored automatically by git.