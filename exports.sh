# shellcheck disable=1090

function _dotfiles_exports() {
  local base_dir="$HOME/.dotfiles/exports"
  local sources=(
    secrets
    bash
    bash-prompt
    rbenv
    github
    homebrew
    yarn
    composer
    gnu-utils
    vim
    z
    ndenv
    nvm
  )

  __dotfiles_profile_includes "$base_dir" "${sources[@]}"

  # Add user `bin` folder to `$PATH`
  export PATH="$HOME/.dotfiles/bin:$PATH"
}

_dotfiles_exports
