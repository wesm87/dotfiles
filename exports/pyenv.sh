# shellcheck shell=bash disable=1090

function __dotfiles_exports_pyenv() {
  local pyenv_dir_path

  if is-mac-os; then
    pyenv_dir_path="$(get-brew-prefix-path pyenv)"
  else
    pyenv_dir_path="${HOME}/.pyenv"
  fi

  export PYENV_ROOT="$pyenv_dir_path"
  export PATH="${PYENV_ROOT}/bin:${PATH}"

  if is-command pyenv; then
    eval "$(pyenv init -)"
  fi
}

__dotfiles_exports_pyenv