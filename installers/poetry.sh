#!/usr/bin/env bash
# shellcheck shell=bash
set -euo pipefail
IFS=$'\n\t'

function __dotfiles_installer_poetry() {
  local -r command_arg="${1:-}"
  local -r poetry_bin_dir_path="${HOME}/.poetry/bin"
  local -r poetry_script_file_path="${poetry_bin_dir_path}/poetry"

  if [[ "$command_arg" == 'update' ]]; then
    poetry self update
  elif [ ! -f "$poetry_script_file_path" ]; then
    curl -sSL https://raw.githubusercontent.com/python-poetry/poetry/master/get-poetry.py | python - --no-modify-path
  fi
}

__dotfiles_installer_poetry "$@"
