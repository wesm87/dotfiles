#!/usr/bin/env bash
# shellcheck shell=bash
set -euo pipefail
IFS=$'\n\t'

function __dotfiles_installer_nvm() {
  local -r nvm_dir_path_default="${HOME}/.nvm"
  local -r nvm_dir_path="${NVM_DIR:-$nvm_dir_path_default}"

  if ! can-source-file "${nvm_dir_path}/nvm.sh"; then
    git clone https://github.com/nvm-sh/nvm.git "$nvm_dir_path"
  else
    cd "$nvm_dir_path"

    git fetch --tags origin

    local -r latest_release_commit=$(git rev-list --tags --max-count=1)
    local -r latest_release_tag=$(git describe --abbrev=0 --tags --match "v[0-9]*" "$latest_release_commit")

    git checkout "$latest_release_tag"
  fi
}

__dotfiles_installer_nvm "$@"
