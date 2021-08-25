# shellcheck shell=bash disable=1090

function __dotfiles_exports_rvm() {
  local -r rvm_dir_path="${HOME}/.rvm"
  local -r rvm_script_file_path="$rvm_dir_path/scripts/rvm"

  export rvm_ignore_dotfiles='yes'
  export RVM_DIR_PATH="$rvm_dir_path"
  export rvm_path="$rvm_dir_path"

  if can-source-file "$rvm_script_file_path"; then
    source "$rvm_script_file_path"
  fi
}

__dotfiles_exports_rvm
