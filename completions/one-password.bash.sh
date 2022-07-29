# shellcheck shell=bash disable=1090

function __dotfiles_completions_one_password_bash() {
  # Bail if OnePassword CLI is not installed
  if ! command -v op &>/dev/null; then
    return
  fi

  source <(op completion bash)
}

__dotfiles_completions_one_password_bash
