# shellcheck shell=bash disable=1090

function __dotfiles_completions_nvm_bash() {
  local nvm_bash_completion_file_path

  nvm_bash_completion_file_path="$NVM_DIR/bash_completion"

  if can-source-file "$nvm_bash_completion_file_path"; then
    source "$nvm_bash_completion_file_path"
  fi
}

__dotfiles_completions_nvm_bash
