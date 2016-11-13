#!/usr/bin/env bash
# shellcheck disable=1090,2155

function _bash_profile_includes() {
  local args=("$@")
  local base_dir="${args[0]}"
  unset args[0]
  local sources="${args[@]}"

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
  )

  _bash_profile_includes "$base_dir" "${sources[@]}"
}

_bash_profile
