# shellcheck shell=bash

# When a new shell is created and this file is loaded for the first time, the
# `string-contains` command is not available because we haven't added ./bin to
# the $PATH value yet. So we set a custom environment variable after we add
# ./bin to the $PATH and check that instead of tying two unrelated concepts
# together. If `string-contains` is not available that's not necessarily a
# direct indicator that we haven't updated the $PATH yet, we could have just
# renamed it and then forgot to update this file.
function __dotfiles_path_exports() {
  local dotfiles_bin_path="$HOME/.dotfiles/bin"

  if [ -z "${__DOTFILES_DID_ADD_USER_BIN_TO_PATH__:-}" ]; then
    export PATH="$dotfiles_bin_path:$PATH"
    export __DOTFILES_DID_ADD_USER_BIN_TO_PATH__='true'
  fi
}

__dotfiles_path_exports
