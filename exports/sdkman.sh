# shellcheck shell=bash

function __dotfiles_exports_sdkman() {
  local -r sdkman_dir_path="${HOME}/.sdkman"

  if [ -d "$sdkman_dir_path" ]; then
    export SDKMAN_DIR="$sdkman_dir_path"
  fi
}

__dotfiles_exports_sdkman
