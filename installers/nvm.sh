#!/usr/bin/env bash
# shellcheck shell=bash
set -euo pipefail
IFS=$'\n\t'

function __dotfiles_installer_nvm() {
  local -r nvm_dir_path_default="${HOME}/.nvm"
  local -r nvm_dir_path="${NVM_DIR:-$nvm_dir_path_default}"

  if ! can-source-file "${nvm_dir_path}/nvm.sh"; then
    curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.37.2/install.sh | bash
  fi
}

__dotfiles_installer_nvm
