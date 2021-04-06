#!/usr/bin/env bash
# shellcheck shell=bash
set -euo pipefail
IFS=$'\n\t'

function __dotfiles_installer_oh_my_zsh() {
  local -r oh_my_zsh_dir_path="${HOME}/.oh-my-zsh"
  local -r oh_my_zsh_custom_dir_path="${HOME}/.dotfiles/oh-my-zsh/custom"
  local -r oh_my_zsh_custom_plugins_dir_path="${oh_my_zsh_custom_dir_path}/plugins"

  if [ ! -d "$oh_my_zsh_dir_path" ]; then
    sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
  fi

  if [ ! -d "${oh_my_zsh_custom_plugins_dir_path}/zsh-autosuggestions" ]; then
    git clone https://github.com/zsh-users/zsh-autosuggestions "$oh_my_zsh_custom_plugins_dir_path/zsh-autosuggestions"
  fi

  if [ ! -d "${oh_my_zsh_custom_plugins_dir_path}/zsh-syntax-highlighting" ]; then
    git clone https://github.com/zsh-users/zsh-syntax-highlighting "$oh_my_zsh_custom_plugins_dir_path/zsh-syntax-highlighting"
  fi
}

__dotfiles_installer_oh_my_zsh
