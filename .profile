#!/usr/bin/env bash
# shellcheck disable=1090,2155

function _bash_profile() {
  local base_dir="$HOME/.dotfiles"

  # shellcheck source=.functions
  source $base_dir/.functions;

  # shellcheck source=.aliases
  source $base_dir/.aliases;

  # shellcheck source=.exports
  source $base_dir/.exports;

  # shellcheck source=.libs
  source $base_dir/.libs;

  # Completions
  source $base_dir/.completions 
}

_bash_profile
