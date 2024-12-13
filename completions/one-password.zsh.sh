# shellcheck shell=bash disable=1090

function __dotfiles_completions_one_password_zsh() {
  # Bail if OnePassword CLI is not installed
  if ! command -v op &>/dev/null; then
    return
  fi

  autoload -Uz compinit
  compinit
  eval "$(op completion zsh)"
  compdef _op op

}

__dotfiles_completions_one_password_zsh
