# shellcheck shell=bash disable=1090

function __dotfiles_profile_includes() {
  local base_dir="${1:-}"
  shift
  # shellcheck disable=2206
  local sources=($*)

  # shellcheck disable=2128
  for file in $sources; do
    [ -f "$base_dir/$file" ] && source "$base_dir/$file"
  done
}

function __dotfiles_is_zsh_env() {
  [[ "$__DOTFILES_IS_ZSH_ENV" = 'true' ]]
}

function __dotfiles_profile() {
  local base_dir="$HOME/.dotfiles"
  local sources
  local env_only_sources=(
    functions.sh
  )
  local profile_only_sources=(
    aliases.sh
    exports.sh
    oh-my-zsh.sh
  )

  if __dotfiles_is_zsh_env; then
    # shellcheck disable=2206,2128
    sources=($env_only_sources)
  else
    # shellcheck disable=2206,2128
    sources=($profile_only_sources)
  fi

  # shellcheck disable=2086,2128
  __dotfiles_profile_includes "$base_dir" $sources
}

function __dotfiles_local_profile() {
  local base_dir="$HOME"
  local sources=(.zshrc.local)

  if ! __dotfiles_is_zsh_env; then
    # shellcheck disable=2086,2128
    __dotfiles_profile_includes "$base_dir" $sources
  fi
}

__dotfiles_profile
__dotfiles_local_profile
