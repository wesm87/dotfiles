#!/usr/bin/env bash
# shellcheck shell=bash
set -euo pipefail
IFS=$'\n\t'

function __dotfiles_installer_heroku_cli() {
  if ! is-command heroku; then
    if is-mac-os && is-command brew; then
      brew tap heroku/brew && brew install heroku
    elif is-linux-os; then
      sudo snap install --classic heroku
    fi
  fi

  if is-command heroku; then
    heroku update && heroku autocomplete
  fi
}

__dotfiles_installer_heroku_cli
