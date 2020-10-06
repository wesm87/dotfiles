# shellcheck shell=bash disable=1090

# When a new shell is created and this file is loaded for the first time, the
# `string-contains` command is not available because we haven't added ./bin to
# the $PATH value yet, so we handle this as a special case.
function __dotfiles_bin_path_exports() {
  local -r dotfiles_bin_path="$HOME/.dotfiles/bin"

  if [ -z "${__DOTFILES_DID_ADD_USER_BIN_TO_PATH__:-}" ]; then
    export PATH="$dotfiles_bin_path:$PATH"
    export __DOTFILES_DID_ADD_USER_BIN_TO_PATH__='true'
  fi
}

function __dotfiles_exports() {
  local -r base_dir="$HOME/.dotfiles/exports"
  local -a sources=(
    gnu-utils.sh
    nvm.sh
    poetry.sh
    rvm.sh
    vim.sh
    yarn.sh
  )

  if [ -n "$BASH" ]; then
    __dotfiles_profile_includes "$base_dir" "${sources[@]}"
  fi

  if [ -n "$ZSH_NAME" ]; then
    # shellcheck disable=2086,2128
    __dotfiles_profile_includes "$base_dir" $sources
  fi
}

__dotfiles_bin_path_exports
__dotfiles_exports
