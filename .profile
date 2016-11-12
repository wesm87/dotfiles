#!/usr/bin/env bash
# shellcheck disable=1090,2155

function _bash_profile_includes() {
  local base_dir="$1"
  local sources="$2"

  for file in "${sources[@]}"; do
    if [ -f "$base_dir/$file" ]; then
      source "$base_dir/$file";
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
  )

  _bash_profile_includes $base_dir $sources
}

_bash_profile
