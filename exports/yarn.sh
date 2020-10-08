# shellcheck shell=bash

function __dotfiles_exports_yarn() {
  prepend-to-path "$(yarn global bin 2>/dev/null)"
}

__dotfiles_exports_yarn
