#!/usr/bin/env bash
set -euo pipefail
IFS=$'\n\t'

function __dotfiles_installer_nvm() {
  local nvm_dir_path

  nvm_dir_path="${NVM_DIR:-$HOME/.nvm}"

  if ! can-source-file "$nvm_dir_path/nvm.sh"; then
    curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.35.3/install.sh | bash
  fi
}

__dotfiles_installer_nvm
