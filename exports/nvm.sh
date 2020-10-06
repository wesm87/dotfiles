# shellcheck shell=bash disable=1090

function __dotfiles_nvm_exports() {
  local nvm_script_file_path

  export NVM_DIR="$HOME/.nvm"

  nvm_script_file_path="$NVM_DIR/nvm.sh"

  if can-source-file "$nvm_script_file_path"; then
    source "$nvm_script_file_path"
  fi
}

__dotfiles_nvm_exports
