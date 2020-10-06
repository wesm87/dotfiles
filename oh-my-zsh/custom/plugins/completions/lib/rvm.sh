# shellcheck shell=bash disable=1090,2206

function __dotfiles_do_rvm_completions() {
  local -r rvm_dir_path="${rvm_path:-$RVM_PATH}"
  local -r rvm_completions_file_path="${rvm_dir_path}/scripts/extras/completion.zsh/_rvm"

  source "$rvm_completions_file_path"
}

function __dotfiles_rvm_completions_zsh() {
  local -r rvm_dir_path="${rvm_path:-$RVM_PATH}"
  local -r rvm_completions_dir_path="${rvm_dir_path}/scripts/extras/completion.zsh"
  local -r rvm_completions_file_path="${rvm_completions_dir_path}/_rvm"

  if [ -d "$rvm_completions_dir_path" ] && can-source-file "$rvm_completions_file_path"; then
    fpath=($rvm_completions_dir_path $fpath)

    compdef __dotfiles_do_rvm_completions rvm
  fi
}

__dotfiles_rvm_completions_zsh
