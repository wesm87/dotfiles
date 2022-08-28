# shellcheck shell=bash

function __dotfiles_exports_sdkman() {
  SDKMAN_DIR="${HOME}/.sdkman"

  if [ -d "$SDKMAN_DIR" ]; then
    export SDKMAN_DIR
  fi
}

__dotfiles_exports_sdkman
