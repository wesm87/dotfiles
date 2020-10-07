# shellcheck shell=bash disable=1090

function __dotfiles_nvm_exports() {
  export NVM_DIR="${HOME}/.nvm"

  local -r nvm_script_file_path="${NVM_DIR}/nvm.sh"

  if can-source-file "$nvm_script_file_path"; then
    source "$nvm_script_file_path"
  fi
}

__dotfiles_nvm_exports
