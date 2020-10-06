#!/usr/bin/env bash
set -euo pipefail
IFS=$'\n\t'

function __dotfiles_installer_vim_vundle() {
  local -r vundle_dir_path="$HOME/.vim/bundle/Vundle.vim"

  if [ ! -d "$vundle_dir_path" ]; then
    git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim
  fi
}

__dotfiles_installer_vim_vundle