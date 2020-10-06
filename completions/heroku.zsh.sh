# shellcheck shell=bash disable=1090

function __dotfiles_heroku_completions_zsh() {
  eval "$(heroku autocomplete:script zsh)"
}

__dotfiles_heroku_completions_zsh
