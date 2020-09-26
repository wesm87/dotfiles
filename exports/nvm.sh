# shellcheck shell=bash
# shellcheck disable=1090

function __dotfiles_nvm_exports() {
  export NVM_DIR="$HOME/.nvm"

  if [ ! -d "$NVM_DIR" ]; then
    curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.35.3/install.sh | bash
  fi

  # npm config delete prefix

  source "$NVM_DIR/nvm.sh"
}

__dotfiles_nvm_exports
