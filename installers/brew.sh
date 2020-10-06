#!/usr/bin/env bash
set -euo pipefail
IFS=$'\n\t'

function __dotfiles_installer_brew() {
  if ! is-command brew; then
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh)"
  fi
}

__dotfiles_installer_brew
