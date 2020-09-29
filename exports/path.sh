# shellcheck shell=bash

function __dotfiles_path_contains() {
  is-command string-contains && string-contains "$1" "$PATH"
}

function __dotfiles_path_exports() {
  local dotfiles_bin_path="$HOME/.dotfiles/bin"

  if ! __dotfiles_path_contains "$dotfiles_bin_path"; then
    export PATH="$dotfiles_bin_path:$PATH"
  fi
}

__dotfiles_path_exports
