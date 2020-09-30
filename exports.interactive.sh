# shellcheck shell=bash disable=1090

function _dotfiles_exports() {
  local base_dir="$HOME/.dotfiles/exports"
  local sources=(
    cli-colors.sh
    vim.sh
    yarn.sh
    z.sh
  )

  if [ -n "$BASH" ]; then
    sources+=(
      bash-git-prompt.sh
    )

    __dotfiles_profile_includes "$base_dir" "${sources[@]}"
  fi

  if [ -n "$ZSH_NAME" ]; then
    sources+=(
      zsh-git-prompt.sh
    )

    # shellcheck disable=2086,2128
    __dotfiles_profile_includes "$base_dir" $sources
  fi
}

_dotfiles_exports
