#!/usr/bin/env bash
# shellcheck shell=bash
set -euo pipefail
IFS=$'\n\t'

function __dotfiles_installer_vim_vundle() {
  local -r command_arg="${1:-}"
  local -r vundle_dir_path="${HOME}/.vim/bundle/Vundle.vim"

  if [[ "$command_arg" == 'update' ]]; then
    vim +PluginUpdate +qall
  elif [ ! -d "$vundle_dir_path" ]; then
    git clone https://github.com/VundleVim/Vundle.vim.git "$vundle_dir_path"
    vim +PluginInstall +qall
  fi
}

__dotfiles_installer_vim_vundle "$@"
