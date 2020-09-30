# shellcheck shell=bash disable=1090

function __dotfiles_profile_includes() {
  local base_dir="${1:-}"
  shift
  local sources="$*"

  for file in $sources; do
    [ -f "$base_dir/$file" ] && source "$base_dir/$file"
  done
}

function __dotfiles_is_bash_rc() {
  [[ "$__DOTFILES_IS_BASH_RC" = 'true' ]]
}

function __dotfiles_profile() {
  local base_dir="$HOME/.dotfiles"
  local rc_sources=(
    functions.sh
    exports.noninteractive.sh
  )
  local profile_sources=(
    aliases.sh
    exports.interactive.sh
    libs.sh
    completions.bash.sh
  )

  __dotfiles_profile_includes "$base_dir" "${rc_sources[@]}"

  if ! __dotfiles_is_bash_rc; then
    __dotfiles_profile_includes "$base_dir" "${profile_sources[@]}"
  fi
}

function __dotfiles_local_profile() {
  local base_dir="$HOME"
  local sources=(
    .bash_profile.local
  )

  __dotfiles_profile_includes "$base_dir" "${sources[@]}"
}

__dotfiles_profile
__dotfiles_local_profile
