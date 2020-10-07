# shellcheck shell=bash disable=1090,2128,2206

function __dotfiles_profile_includes() {
  local base_dir="${1:-}"
  shift
  local sources=($*)

  for file in $sources; do
    local -r full_path="${base_dir}/${file}"

    if "${HOME}/.dotfiles/bin/can-source-file" "$full_path"; then
      source "$full_path"
    fi
  done
}

function __dotfiles_is_zsh_env() {
  [[ "$__DOTFILES_IS_ZSH_ENV" = 'true' ]]
}

function __dotfiles_profile() {
  local base_dir="${HOME}/.dotfiles"
  local sources
  local env_sources=(
    functions.sh
    exports.noninteractive.sh
  )
  local profile_sources=(
    exports.interactive.sh
    completions.zsh.sh
    oh-my-zsh/oh-my-zsh.sh
    aliases.sh
  )

  if __dotfiles_is_zsh_env; then
    sources=($env_sources)
  else
    sources=($profile_sources)
  fi

  # shellcheck disable=2086
  __dotfiles_profile_includes "$base_dir" $sources
}

function __dotfiles_local_profile() {
  local base_dir="$HOME"
  local sources=(
    .zshrc.local
  )

  if ! __dotfiles_is_zsh_env; then
    # shellcheck disable=2086
    __dotfiles_profile_includes "$base_dir" $sources
  fi
}

__dotfiles_profile
__dotfiles_local_profile
