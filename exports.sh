# shellcheck disable=1090

function _dotfiles_exports() {
  local base_dir="$HOME/.dotfiles/exports"
  local sources=(
    rbenv
    yarn
    gnu-utils
    vim
    z
    nvm
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

  # Add user `bin` folder to `$PATH`
  export PATH="$HOME/.dotfiles/bin:$PATH"
}

_dotfiles_exports
