# shellcheck shell=bash disable=1090

function __dotfiles_exports() {
  local -r base_dir="${HOME}/.dotfiles/exports"
  local -a sources=(
    dotfiles-bin-path.sh
    brew.sh
    gnu-utils.sh
    poetry.sh
    vim.sh
    docker.sh
    nix-shell.sh
    pyenv.sh
    nvm.sh
    rvm.sh
    jenv.sh
    sdkman.sh
  )

  if [ -n "$BASH" ]; then
    __dotfiles_profile_includes "$base_dir" "${sources[@]}"
  fi

  if [ -n "$ZSH_NAME" ]; then
    # shellcheck disable=2086,2128
    __dotfiles_profile_includes "$base_dir" $sources
  fi
}

__dotfiles_exports
