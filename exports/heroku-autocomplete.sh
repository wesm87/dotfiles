# shellcheck shell=bash
# shellcheck disable=1090

function __dotfiles_heroku_autocomplete_exports() {
  local heroku_autocomplete_setup_path="$HOME/.cache/heroku/autocomplete/zsh_setup"

  test -f "$heroku_autocomplete_setup_path" && source "$heroku_autocomplete_setup_path"
}

__dotfiles_heroku_autocomplete_exports
