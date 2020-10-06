# shellcheck shell=bash disable=1090

function __dotfiles_exports() {
  local -r base_dir="$HOME/.dotfiles/exports"
  local -a sources=(
    gnu-utils.sh
    nvm.sh
    poetry.sh
    rvm.sh
    vim.sh
    yarn.sh
  )

  # Add custom bin path
  prepend-to-path "$HOME/.dotfiles/bin"

  if [ -n "$BASH" ]; then
    __dotfiles_profile_includes "$base_dir" "${sources[@]}"
  fi

  if [ -n "$ZSH_NAME" ]; then
    # shellcheck disable=2086,2128
    __dotfiles_profile_includes "$base_dir" $sources
  fi
}

__dotfiles_exports
