# shellcheck shell=bash

function vim_exports() {
  # We use single-quotes intentionally to disable variable interpolation
  # shellcheck disable=2016
  export VIMINIT='source $MYVIMRC'
  export MYVIMRC="$HOME/.dotfiles/config/vimrc"
  export EDITOR='vim'
}

vim_exports
