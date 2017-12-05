#!/usr/bin/env bash
# shellcheck disable=1090

function _bash_profile_includes() {
  local base_dir="$1"
  shift
  local sources="$*"

  for file in $sources; do
    local full_path="$base_dir/$file"
    if [ -f "$full_path" ]; then
      source "$full_path"
    fi
  done
}

function _bash_profile() {
  local base_dir="$HOME/.dotfiles"
  local sources=(
    .functions
    .aliases
    .exports
    .libs
    .completions
    .profile.local
  )

  _bash_profile_includes "$base_dir" "${sources[@]}"
}

_bash_profile
