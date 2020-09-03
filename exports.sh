# shellcheck disable=1090

function _dotfiles_exports() {
  local base_dir="$HOME/.dotfiles/exports"
  local sources=(
    path
    gnu-utils
    vim
    yarn
    z
    nvm
    # rbenv
    rvm
  )

  if [ -n "$BASH" ]; then
    local bash_only_sources=(
      bash
      bash-prompt 
    )

    __dotfiles_profile_includes "$base_dir" "${sources[@]}"
    __dotfiles_profile_includes "$base_dir" "${bash_only_sources[@]}"
  fi

  if [ -n "$ZSH_NAME" ]; then
    local zsh_only_sources=(
      zsh-prompt
    )

    __dotfiles_profile_includes "$base_dir" $sources
    __dotfiles_profile_includes "$base_dir" $zsh_only_sources
  fi
}

_dotfiles_exports
