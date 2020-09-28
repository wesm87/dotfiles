# shellcheck shell=bash

function __dotfiles_path_exports() {
  local dotfiles_bin_path="$HOME/.dotfiles/bin"

  if ! string-contains "$dotfiles_bin_path" "$PATH"; then
    export PATH="$HOME/.dotfiles/bin:$PATH"
  fi
}

__dotfiles_path_exports
