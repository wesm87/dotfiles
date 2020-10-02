# shellcheck shell=bash disable=1090

function __dotfiles_bash_completions() {
  if is-linux-os; then
    bash_completions_file_path='/usr/share/bash-completion/bash_completion'
    fallback_bash_completions_file_path='/etc/bash_completion'

    if can-source-file "$bash_completions_file_path"; then
      source "$bash_completions_file_path"
    elif can-source-file "$fallback_bash_completions_file_path"; then
      source "$fallback_bash_completions_file_path"
    fi
  fi
}

__dotfiles_bash_completions
