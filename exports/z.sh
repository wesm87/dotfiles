# shellcheck shell=bash

function z_exports() {
  local current_user

  current_user=$(whoami)

  export _Z_DATA="$HOME/.dotfiles/data/z"
  export _Z_OWNER="$current_user"
}

z_exports
