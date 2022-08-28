# shellcheck shell=bash

function __dotfiles_exports_jenv() {
  if ! is-command brew; then
    return
  fi

  local -r jenv_brew_install_path="$(brew --prefix jenv)"
  local -r jenv_bin_path="${HOME}/.jenv/bin"

  if [ -d "$jenv_brew_install_path" ]; then
    prepend-to-path "$jenv_bin_path"
    eval "$(jenv init -)"
  fi
}

__dotfiles_exports_jenv
