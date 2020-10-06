# shellcheck shell=bash disable=1090,2206

function __dotfiles_rvm_completions_zsh() {
  local -r rvm_dir_path="${rvm_path:-$RVM_PATH}"
  local -r rvm_completions_file_path="${rvm_dir_path}/scripts/extras/completion.bash"

  if can-source-file "$rvm_completions_file_path"; then
    source "$rvm_completions_file_path"
  fi
}

__dotfiles_rvm_completions_zsh
