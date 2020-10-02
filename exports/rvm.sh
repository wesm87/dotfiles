# shellcheck shell=bash
# shellcheck disable=1090

function __dotfiles_rvm_exports() {
  local rvm_script_file_path

  export rvm_ignore_dotfiles='yes'
  export RUBY_VERSION="${RUBY_VERSION:-ruby-2.7.0}"
  export RVM_PATH="$HOME/.rvm"
  export RVM_DIR="$RVM_PATH"
  export rvm_path="$RVM_PATH"

  rvm_script_file_path="$RVM_PATH/scripts/rvm"

  if ! can-source-file "$rvm_script_file_path"; then
    gpg2 --recv-keys 409B6B1796C275462A1703113804BB82D39DC0E3 7D2BAF1CF37B13E2069D6956105BD0E739499BDB
    curl -sSL https://get.rvm.io | bash -s stable --ruby --ignore-dotfiles
  fi

  if can-source-file "$rvm_script_file_path"; then
    source "$rvm_script_file_path"
  fi
}

__dotfiles_rvm_exports
