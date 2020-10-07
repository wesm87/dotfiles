#!/usr/bin/env bash
# shellcheck shell=bash disable=1090

function __dotfiles_install() {
  local -r dotfiles_installers_dir_path="${HOME}/.dotfiles/installers"

  if [ -d "$dotfiles_installers_dir_path" ]; then
    for installer_file in "${dotfiles_installers_dir_path}/"*.sh; do
      echo "$installer_file"
      [ -x "$installer_file" ] && "$installer_file"
    done
  fi

  ./install-deps.sh
}

__dotfiles_install
