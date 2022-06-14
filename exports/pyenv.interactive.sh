# shellcheck shell=bash disable=1090

function __dotfiles_exports_pyenv_interactive() {
  export PYENV_ROOT="${HOME}/.pyenv"

  prepend-to-path "${PYENV_ROOT}/bin"

  if is-command pyenv; then
    eval "$(pyenv init --path)"
  fi
}

__dotfiles_exports_pyenv_interactive
