# shellcheck shell=bash disable=1090

function __dotfiles_completions_heroku_zsh() {
  eval "$(heroku autocomplete:script zsh)"
}

__dotfiles_completions_heroku_zsh
