# dotfiles

This repo contains most of my configuration file for working environment including:

- bashrc
- zshrc
- vimrc
- vim (directory)

## Installation
clone the repository to the home directory, together with the submodules, and run the setup script

    cd ~
    git clone git@bitbucket.org:bxchen/dotfiles.git && cd dotfiles
    git submodule init && git submodule update
    bash setup.sh

### notes on the `setup.sh`
1. move existing config files in `$HOME` to a backup directory
   `$HOME/.dotfiles_old`
2. create symlinks in `$HOME` to the corresponding config files in the repo. By
   default, the repo and the backup directory is sitting in `$HOME`. Set it in
   `setup.sh` if otherwise.
