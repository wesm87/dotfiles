# shellcheck shell=bash
# shellcheck disable=1090

function __dotfiles_nvm_exports() {
  local nvm_script_path
  local nvm_bash_completion_path

  export NVM_DIR="$HOME/.nvm"

  nvm_script_path="$NVM_DIR/nvm.sh"

  if [ ! -s "$nvm_script_path" ]; then
    curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.35.3/install.sh | bash
  fi

  if [ -s "$nvm_script_path" ]; then
    source "$nvm_script_path"
  fi

  nvm_bash_completion_path="$NVM_DIR/bash_completion"

  if __dotfiles_is_bash && [ -s "$nvm_bash_completion_path" ]; then
    source "$nvm_bash_completion_path"
  fi
}

__dotfiles_nvm_exports
