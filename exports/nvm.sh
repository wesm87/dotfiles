# shellcheck shell=bash disable=1090

function __dotfiles_exports_nvm() {
  export NVM_DIR="${HOME}/.nvm"

  local -r nvm_script_file_path_for_brew_install="/opt/homebrew/opt/nvm/nvm.sh"
  local -r nvm_script_file_path_for_manual_install="${NVM_DIR}/nvm.sh"

  # When NVM is installed via Homebrew, sourcing this script will take care of
  # setting `NVM_DIR`, linking brew files into `NVM_DIR`, and sourcing `nvm.sh`
  if can-source-file "$nvm_script_file_path_for_brew_install"; then
    source "$nvm_script_file_path_for_brew_install"
  elif can-source-file "$nvm_script_file_path_for_manual_install"; then
    source "$nvm_script_file_path_for_manual_install"
  fi
}

__dotfiles_exports_nvm
