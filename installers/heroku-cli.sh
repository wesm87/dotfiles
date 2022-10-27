#!/usr/bin/env bash
# shellcheck shell=bash
set -euo pipefail
IFS=$'\n\t'

function __dotfiles_installer_heroku_cli() {
  if ! "${HOME}/.dotfiles/bin/is-command" heroku; then
    if "${HOME}/.dotfiles/bin/is-mac-os" && "${HOME}/.dotfiles/bin/is-command" brew; then
      brew tap heroku/brew && brew install heroku
    elif "${HOME}/.dotfiles/bin/is-linux-os"; then
      sudo snap install --classic heroku
    fi
  else
    heroku update && heroku autocomplete
  fi
}

__dotfiles_installer_heroku_cli
