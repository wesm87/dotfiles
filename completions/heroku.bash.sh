# shellcheck shell=bash disable=1090

function __dotfiles_heroku_completions_bash() {
  local heroku_completions_file_path="$HOME/.cache/heroku/autocomplete/bash_setup"

  can-source-file "$heroku_completions_file_path" && source "$heroku_completions_file_path"
}

__dotfiles_heroku_completions_bash
