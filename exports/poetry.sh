# shellcheck shell=bash disable=1090

function __dotfiles_exports_poetry() {
  export POETRY_HOME="${HOME}/.poetry"

  prepend-to-path "${POETRY_HOME}/bin"
}

__dotfiles_exports_poetry
