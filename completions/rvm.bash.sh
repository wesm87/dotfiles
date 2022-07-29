# shellcheck shell=bash disable=1090,2206

function __dotfiles_completions_rvm_zsh() {
  # Bail if RVM is not installed
  if ! command -v rvm &>/dev/null; then
    return
  fi

  local -r rvm_dir_path="${rvm_path:-$RVM_PATH}"
  local -r rvm_completions_file_path="${rvm_dir_path}/scripts/extras/completion.bash"

  if can-source-file "$rvm_completions_file_path"; then
    source "$rvm_completions_file_path"
  fi
}

__dotfiles_completions_rvm_zsh
