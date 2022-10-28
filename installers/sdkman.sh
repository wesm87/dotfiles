#!/usr/bin/env bash
# shellcheck shell=bash
set -euo pipefail
IFS=$'\n\t'

function __dotfiles_installer_sdkman() {
  local -r sdkman_dir_path="${HOME}/.sdkman"

  export SDKMAN_DIR="$sdkman_dir_path"

  if [ ! -d "$sdkman_dir_path" ]; then
    curl -s "https://get.sdkman.io?rcupdate=false" | bash
  else
    sdk update
    sdk selfupdate
  fi
}

__dotfiles_installer_sdkman "$@"
