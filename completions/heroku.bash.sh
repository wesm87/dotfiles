# shellcheck shell=bash disable=1090

function __dotfiles_heroku_completions_bash() {
  eval "$(heroku autocomplete:script bash)"
}

__dotfiles_heroku_completions_bash
