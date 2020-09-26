# shellcheck shell=bash
# shellcheck disable=1090

function __dotfiles_rvm_exports() {
  export RUBY_VERSION="${RUBY_VERSION:-ruby-2.7.1}"
  export RVM_DIR="$HOME/.rvm"
  export GEM_HOME="${RVM_DIR}/gems/${RUBY_VERSION}"

  if [ ! -d "$RVM_DIR" ]; then
    gpg2 --recv-keys 409B6B1796C275462A1703113804BB82D39DC0E3 7D2BAF1CF37B13E2069D6956105BD0E739499BDB
    curl -sSL https://get.rvm.io | bash -s stable
  fi

  RVM_SCRIPTS_DIR="$RVM_DIR/scripts"

  if [ ! -d "$RVM_SCRIPTS_DIR" ]; then
    RVM_SCRIPTS_DIR='/usr/share/rvm/scripts'
  fi

  source "$RVM_SCRIPTS_DIR/rvm"
}

__dotfiles_rvm_exports
