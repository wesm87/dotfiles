# shellcheck shell=bash disable=1090

function __dotfiles_exports_pyenv() {
  if is-command pyenv; then
    eval "$(pyenv init -)"
  fi
}

__dotfiles_exports_pyenv
