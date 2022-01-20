#!/usr/bin/env bash
# shellcheck shell=bash
set -euo pipefail
IFS=$'\n\t'

function __dotfiles_gpg_import_keys() {
  if is-command gpg2; then
    gpg2 --recv-keys "$@"
  elif is-command gpg; then
    gpg --recv-keys "$@"
  fi
}

function __dotfiles_installer_rvm() {
  local -r rvm_dir_path="${HOME}/.rvm"
  local -r rvm_script_file_path="${rvm_dir_path}/scripts/rvm"

  if ! can-source-file "$rvm_script_file_path"; then
    __dotfiles_gpg_import_keys 409B6B1796C275462A1703113804BB82D39DC0E3 7D2BAF1CF37B13E2069D6956105BD0E739499BDB

    curl -sSL https://get.rvm.io | bash -s stable --ruby --ignore-dotfiles
  else
    rvm get stable
  fi
}

__dotfiles_installer_rvm "$@"
