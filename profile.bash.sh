# shellcheck shell=bash

function __dotfiles_profile_includes() {
  local base_dir="${1:-}"
  shift
  local sources="$*"

  for file in $sources; do
    # shellcheck disable=1090
    [ -f "$base_dir/$file" ] && source "$base_dir/$file"
  done
}

function __dotfiles_profile() {
  local base_dir="$HOME/.dotfiles"
  local sources=(
    functions.sh
    aliases.sh
    exports.sh
    libs.sh
    completions.sh
  )

  __dotfiles_profile_includes "$base_dir" "${sources[@]}"
}

function __dotfiles_local_profile() {
  local base_dir="$HOME"
  local sources=(.bash_profile.local)

  __dotfiles_profile_includes "$base_dir" "${sources[@]}"
}

__dotfiles_profile
__dotfiles_local_profile
