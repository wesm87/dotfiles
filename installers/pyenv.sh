#!/usr/bin/env bash
# shellcheck shell=bash
set -euo pipefail
IFS=$'\n\t'

function __dotfiles_installer_pyenv() {
  local -r command_arg="${1:-}"
  local -r pyenv_dir_path="${HOME}/.pyenv"

  if [[ "$command_arg" == 'update' ]]; then
    if is-mac-os; then
      brew upgrade pyenv
    else
      pyenv update
    fi
  elif [ ! -d "$pyenv_dir_path" ]; then
    if is-mac-os; then
      brew install pyenv
    else
      git clone https://github.com/pyenv/pyenv.git "$pyenv_dir_path"
      git clone https://github.com/pyenv/pyenv-update.git "${pyenv_dir_path}/plugins/pyenv-update"
    fi
  fi
}

__dotfiles_installer_pyenv "$@"
