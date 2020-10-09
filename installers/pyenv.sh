#!/usr/bin/env bash
set -euo pipefail
IFS=$'\n\t'

function __dotfiles_installer_pyenv() {
  local -r pyenv_dir_path="${HOME}/.pyenv"

  if [ ! -d "$pyenv_dir_path" ]; then
    if is-mac-os; then
      brew install pyenv
    else
      git clone https://github.com/pyenv/pyenv.git "$pyenv_dir_path"
    fi
  fi
}

__dotfiles_installer_pyenv
