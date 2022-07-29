# shellcheck shell=bash disable=1090

function __dotfiles_completions_heroku_bash() {
  # Bail if Heroku CLI is not installed
  if ! command -v heroku &>/dev/null; then
    return
  fi

  eval "$(heroku autocomplete:script bash)"
}

__dotfiles_completions_heroku_bash
