# shellcheck shell=bash

function __dotfiles_vim_exports() {
  # We use single-quotes intentionally to disable variable interpolation
  # shellcheck disable=2016
  export VIMINIT='source $MYVIMRC'
  export MYVIMRC="$HOME/.dotfiles/config/vimrc"
  export EDITOR='vim'
}

__dotfiles_vim_exports
