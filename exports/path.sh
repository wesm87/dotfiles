# shellcheck shell=bash

function __dotfiles_path_exports() {
  export PATH="$HOME/.dotfiles/bin:$PATH"
}

__dotfiles_path_exports
