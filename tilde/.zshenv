# shellcheck shell=bash disable=1090

__DOTFILES_IS_ZSH_ENV='true' source "${HOME}/.dotfiles/profile.zsh.sh"

function __dotfiles_zshenv() {
  local less_options=(
    # If the entire text fits on one screen, just show it and quit. (Be more
    # like "cat" and less like "more".)
    --quit-if-one-screen

    # Do not clear the screen first.
    --no-init

    # Like "smartcase" in Vim: ignore case unless the search pattern is mixed.
    --ignore-case

    # Do not automatically wrap long lines.
    --chop-long-lines

    # Allow ANSI colour escapes, but no other escapes.
    --RAW-CONTROL-CHARS

    # Do not ring the bell when trying to scroll past the end of the buffer.
    --quiet

    # Do not complain when we are on a dumb terminal.
    --dumb
  )

  export LC_ALL='en_US.UTF-8'
  export LANG='en_US'
  export LESS="${less_options[*]}"
}

__dotfiles_zshenv
