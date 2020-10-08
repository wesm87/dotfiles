# shellcheck shell=bash disable=1090

function __dotfiles_exports_poetry() {
  prepend-to-path "${HOME}/.poetry/bin"
}

__dotfiles_exports_poetry
