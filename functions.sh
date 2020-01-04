# shellcheck disable=1090

function __dotfiles_functions() {
  local base_dir="$HOME/.dotfiles/functions"
  local sources=(
    public.sh
    private.sh
    logging.sh
    proxy.sh
  )

  __dotfiles_profile_includes "$base_dir" "${sources[@]}"
}

__dotfiles_functions
