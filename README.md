# Dotfiles

My personal dotfiles repository

![](https://raw.githubusercontent.com/Manu343726/dotfiles/master/dotfiles.png)

## Install

Just run `install.sh`, it takes care of everything!

    bash -c "$(curl -fsSL https://raw.github.com/Manu343726/dotfiles/master/install.sh)" --noconfirm

## Features
 
 - No external dependencies. Just bash and git
 - Portable package management
 - Isolated configuration everything-in-one-place directory
 - Version Control friendly

## Philosophy

The idea of this repo is to have a declarative way to manage configuration bootstrapping. I hate setting up terminals, editors, etc with the fancy schemes and tools I like, so I tried to automate as more as possible.

To make version control of configuration simple and painless, all configuration is placed in your `$HOME/.dotfiles` directory. Then all different scripts, directories etc are symlinked from their usual locations to their `.dotfiles` counterparts.

### Targets and components

Linux means Do It On Your Own. Terminal colorschemes, text editors, shells, keyboard bindings... You are able to customize **everything**, but, as soon as you are comfortable with your current setup, you have to work in another computer and start again!
Think of each setup menctioned above: The terminal setup, text editor configuration, etc. We can call them ***configuration targets*** or just "*targets"*. The different subsystems where you have a preferred configuration.  
For each target there could be multiple things to configure. Think about vim: Vim itself could be one of our targets, but we have to manage the `.vimrc` file, the `.vim` folder with colorschemes and plugins, etc. Even the vim program itself! That is, the vim configuration target is made up of multiple ***components***.

    vim:

     - .vimrc file
     - .vim/ directory
     - vim program
     ...


Here in `dotfiles` we define targets as directories inside the repository, each one with the configuration components needed and an `install.sh` script which says **how the target components should be installed in your system**.
But what "*install*" means? For program components, like vim client, it's easy: Means installing the program in your system, using the system package manager for example.  
But for configuration files and folders, installing means we should place those in the directories programs expect: Following with the vim example, vim expects `.vimrc` file to be located at `$HOME/.vimrc`, and `.vim/` folder at `$HOME/.vim/`.
`dotfiles` does a little trick here: Instead of copying that files to their respective locations, we symlink them so you can continue working with your VCSed configuration files.

    + $HOME
    |
    +-+ .dotfiles/
    | |
    | +-+ vim/ # The vim target
    |   |-- .vimrc
    |   |-- .vim/
    |   |-- install.sh
    |
    |-- .vimrc -> .dotfiles/.vimrc
    |-- .vim/ -> .dotfiles/.vim/

**TL;DR: Installing a component means...**

 - **Installing a package**, if the component is a program
 - **Linking from their location inside `.dotfiles` to the expected system path**, if the component is a configuration file or folder.

As you would imagine, installing a target means installing all its components

### Dotfiles framework

Since dotfiles requires a lot of bash black magic under the hood, all implementation details such as commands implementation, dependencies, etc are placed inside a hidden `.dotfileslib` directory in `dotfiles` top directory.

### Package management

One of the main goals of dotfails is to make bootstrapping of a new machine painless, regardless is an Ubuntu box, Arch, Fedora, etc. In that way, dotfiles wraps package management with its own commands to install packages in a portable way

#### Package database

Most linux distros have their own package names for the same software, so you usually have to remember how a program is called in each distro you work with. Dotfiles automates this by maintaining a package translation database, where you index distro-specific package names by a generic package name and the distro you are running:

    generic_name , distro -> distro_specific_name

That database is stored in `.dotfileslib/.package-database` file with format `GENERIC_NAME DISTRO DISTRO_SPECIFIC_NAME`. A command line tool `package-database.sh` (In `.dotfileslib/` too) is provided to ask for and register new packages:

`package-database.sh` has the following commands:

 - **`find-package --generic-name <generic-name> [--distro <distro>]`**: Gives the distro-specific name of a package. If no `--distro` parameter is passed, it's guessed from environment. If found, writes package name to stdout and return 0, else returns -1
 - **`register-package --generic-name <generic-name> --name <name> [--distro <distro>]`**: Registers a new entry. **Checks first** in the database so no duplicates are added.

To install a package in a portable way, call `dotfiles_install_package <generic-name>` in your target `install.sh` file. Note `dotfiles_install_package` may ask you for registering the package if is not found.

### Installing components

File/folder components are installed using the following commands in the target `install.sh` file:

 - **`dotfiles_install_component <component> <dest>`**: Installs the component `<component>` as `<dest>`. Note `<component>` is relative to the target directory, but `<dest>` is the absolute destination path. This command creates a `<component>.pre-dotfiles` backup file/folder/symlink prior to install if the destination already exists.
 - **`dotfiles_install_remote_component <provider> <URL> <component> [<dest>]`**: The component is not physically in the target folder but should be downloaded first. This command retreives the `<component>` given an `<URL>` and a `<provider>` (GIT, GITHUB, WGET, CURL). If `<dest>` is passed, invokes `dotfiles_install_component <component> <dest>` after download. 
 *NOTE: Remote components, such as github projects and alike, are not meant to live inside the target directory nor tracked for changes, so they are automatically ignored by a per-target `.gitignore` file. This reduces overhead when deploying (pushing) configuration changes. If you want to track changes, consider cloning (Or adding the component as a submodule) and switch to `dotfiles_install_component` command.*
