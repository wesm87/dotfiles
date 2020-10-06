# shellcheck shell=bash disable=1090

function __dotfiles_rvm_exports() {
  local -r rvm_dir_path="${HOME}/.rvm"
  local -r default_ruby_version="ruby-2.7.0"
  local -r rvm_script_file_path="$rvm_dir_path/scripts/rvm"

  export rvm_ignore_dotfiles='yes'
  export RUBY_VERSION="${RUBY_VERSION:-$default_ruby_version}"
  export RVM_DIR_PATH="$rvm_dir_path"
  export rvm_path="$rvm_dir_path"

  if can-source-file "$rvm_script_file_path"; then
    source "$rvm_script_file_path"
  fi
}

__dotfiles_rvm_exports
