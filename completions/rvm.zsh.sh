# shellcheck shell=bash disable=1090,2206

function __dotfiles_rvm_completions_zsh() {
  local rvm_completions_dir_path="$RVM_PATH/scripts/zsh/Completion"
  local rvm_completions_file_path="$rvm_completions_dir_path/_rvm"

  if [ -d "$rvm_completions_dir_path" ] && can-source-file "$rvm_completions_file_path"; then
    fpath=($rvm_path/scripts/zsh/Completion $fpath)

    function _rvm_completion() {
      source "$rvm_completions_file_path"
    }

    compdef _rvm_completion rvm
  fi
}

__dotfiles_rvm_completions_zsh
