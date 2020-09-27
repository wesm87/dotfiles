# shellcheck shell=bash

function __dotfiles_z_exports() {
  local current_user="$USER"

  export _Z_DATA="$HOME/.dotfiles/data/z"
  export _Z_OWNER="$current_user"
}

__dotfiles_z_exports
