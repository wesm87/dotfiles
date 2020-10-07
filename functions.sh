# shellcheck shell=bash
# shellcheck disable=1090

function __dotfiles_is_bash() {
  [[ -n "${BASH:-}" || -n "${BASH_VERSION:-}" ]]
}

function __dotfiles_is_zsh() {
  [[ -n "${ZSH_NAME:-}" || -n "${ZSH_VERSION:-}" ]]
}

function __dotfiles_functions() {
  local base_dir="${HOME}/.dotfiles/functions"
  local sources=(
    fp.sh
    public.sh
    private.sh
    # logging.sh
    # proxy.sh
  )

  if __dotfiles_is_bash; then
    __dotfiles_profile_includes "$base_dir" "${sources[@]}"
  fi

  if __dotfiles_is_zsh; then
    # shellcheck disable=2086,2128
    __dotfiles_profile_includes "$base_dir" $sources
  fi
}

__dotfiles_functions
