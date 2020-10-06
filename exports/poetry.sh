# shellcheck shell=bash disable=1090

function __dotfiles_poetry_exports() {
  prepend-to-path "${HOME}/.poetry/bin"
}

__dotfiles_poetry_exports
