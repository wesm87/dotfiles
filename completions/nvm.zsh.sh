# shellcheck shell=bash disable=1090

function __dotfiles_completions_nvm_zsh() {
  # Bail if NVM is not installed
  if ! command -v nvm &>/dev/null; then
    return
  fi

  local nvm_bash_completion_file_path="$NVM_DIR/bash_completion"

  #* Uses `bashcompinit` to generate ZSH completions from Bash completions.
  if can-source-file "$nvm_bash_completion_file_path"; then
    source "$nvm_bash_completion_file_path"
  fi
}

__dotfiles_completions_nvm_zsh
