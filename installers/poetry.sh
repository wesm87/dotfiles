#!/usr/bin/env bash
# shellcheck shell=bash
set -euo pipefail
IFS=$'\n\t'

function __dotfiles_installer_poetry() {
  local -r poetry_bin_dir_path="${HOME}/.local/bin"
  local -r poetry_script_file_path="${poetry_bin_dir_path}/poetry"

  if [ ! -f "$poetry_script_file_path" ]; then
    curl -sSL https://install.python-poetry.org | python -
  else
    poetry self update
  fi
}

__dotfiles_installer_poetry "$@"
