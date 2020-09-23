# shellcheck shell=bash
# shellcheck disable=1090

function __dotfiles_functions() {
  local base_dir="$HOME/.dotfiles/functions"
  local sources=(
    public.sh
    private.sh
    # logging.sh
    # proxy.sh
  )

  if [ -n "$BASH" ]; then
    __dotfiles_profile_includes "$base_dir" "${sources[@]}"
  fi

  if [ -n "$ZSH_NAME" ]; then
    # shellcheck disable=2086,2128
    __dotfiles_profile_includes "$base_dir" $sources
  fi
}

__dotfiles_functions
