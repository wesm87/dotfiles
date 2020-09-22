# shellcheck disable=1090

function _dotfiles_exports() {
  local base_dir="$HOME/.dotfiles/exports"
  local sources=(
    path.sh
    gnu-utils.sh
    ls-colors.sh
    vim.sh
    yarn.sh
    z.sh
    nvm.sh
    # RVM has to be last or it will complain about the current Ruby path
    # not being at the very beginning of the $PATH variable.
    rvm.sh
  )

  if [ -n "$BASH" ]; then
    local bash_only_sources=(
      bash-prompt.sh
    )

    __dotfiles_profile_includes "$base_dir" "${sources[@]}"
    __dotfiles_profile_includes "$base_dir" "${bash_only_sources[@]}"
  fi

  if [ -n "$ZSH_NAME" ]; then
    local zsh_only_sources=(
      zsh-prompt.sh
    )

    __dotfiles_profile_includes "$base_dir" $sources
    __dotfiles_profile_includes "$base_dir" $zsh_only_sources
  fi
}

_dotfiles_exports
