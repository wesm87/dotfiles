# shellcheck shell=bash

function __dotfiles_yarn_exports() {
  prepend-to-path "$(yarn global bin 2>/dev/null)"
}

__dotfiles_yarn_exports
