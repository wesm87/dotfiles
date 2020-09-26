# shellcheck shell=bash

function __dotfiles_profile_includes() {
  local base_dir="${1:-}"
  shift
  # shellcheck disable=2206
  local sources=($*)

  # shellcheck disable=2128
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
    oh-my-zsh.zsh
  )

  # shellcheck disable=2086,2128
  __dotfiles_profile_includes "$base_dir" $sources
}

function __dotfiles_local_profile() {
  local base_dir="$HOME"
  local sources=(.zshrc.local)

  # shellcheck disable=2086,2128
  __dotfiles_profile_includes "$base_dir" $sources
}

__dotfiles_profile
__dotfiles_local_profile
