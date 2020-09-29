# shellcheck shell=bash

function __dotfiles_rbenv_exports() {
  if ! is-command brew; then
    return
  fi

  RBENV_ROOT="$(brew --prefix rbenv)"

  if [ -d "$RBENV_ROOT" ]; then
    # Contains Ruby versions and shims.
    export RBENV_ROOT

    # Initialize rbenv.
    eval "$(rbenv init -)"

    # Set global version if one isn't already set.
    if [ -z "$(rbenv global)" ]; then
      rbenv global 2.7.0
    fi
  fi
}

__dotfiles_rbenv_exports
