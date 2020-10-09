# shellcheck shell=bash disable=1090

function __dotfiles_profile_includes() {
  local base_dir="${1:-}"
  shift
  local sources="$*"
  local full_path

  for file in $sources; do
    full_path="${base_dir}/${file}"

    if "${HOME}/.dotfiles/bin/can-source-file" "$full_path"; then
      source "$full_path"
    fi
  done
}

function __dotfiles_is_bash_rc() {
  [[ "$__DOTFILES_IS_BASH_RC" = 'true' ]]
}

function __dotfiles_profile() {
  local base_dir="${HOME}/.dotfiles"
  local rc_sources=(
    functions.sh
    exports.noninteractive.sh
  )
  local profile_sources=(
    exports.interactive.sh
    completions.bash.sh
    libs.sh
    aliases.sh
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
