# shellcheck shell=bash disable=1090

function _dotfiles_exports() {
  local base_dir="$HOME/.dotfiles/exports"
  local sources=(
    path.sh
    gnu-utils.sh
    nvm.sh
    # RVM has to be last or it will complain about the current Ruby path
    # not being at the very beginning of the $PATH variable.
    rvm.sh
  )

  if [ -n "$BASH" ]; then
    __dotfiles_profile_includes "$base_dir" "${sources[@]}"
  fi

  if [ -n "$ZSH_NAME" ]; then
    # shellcheck disable=2086,2128
    __dotfiles_profile_includes "$base_dir" $sources
  fi
}

_dotfiles_exports
