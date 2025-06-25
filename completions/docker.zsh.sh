# shellcheck shell=bash disable=1090

function __dotfiles_completions_docker_zsh() {
  # Bail if OnePassword CLI is not installed
  if ! command -v docker &>/dev/null; then
    return
  fi

  autoload -Uz compinit
  compinit
  eval "$(docker completion zsh)"
  compdef _docker docker

}

__dotfiles_completions_docker_zsh
