# shellcheck shell=bash disable=1090

function __dotfiles_completions_heroku_zsh() {
  # Bail if Heroku CLI is not installed
  if ! command -v heroku &>/dev/null; then
    return
  fi

  eval "$(heroku autocomplete:script zsh)"
}

__dotfiles_completions_heroku_zsh
