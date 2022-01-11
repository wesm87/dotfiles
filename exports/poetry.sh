# shellcheck shell=bash disable=1090

function __dotfiles_exports_poetry() {
  prepend-to-path "${HOME}/.local/bin"
}

__dotfiles_exports_poetry
