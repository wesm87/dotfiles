# shellcheck shell=bash disable=1090

function __dotfiles_completions_heroku_bash() {
  eval "$(heroku autocomplete:script bash)"
}

__dotfiles_completions_heroku_bash
