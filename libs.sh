# shellcheck disable=1090

function __dotfiles_libs() {
  local libs_dir="$HOME/.dotfiles/libs"

  source $libs_dir/z/z.sh
}

__dotfiles_libs
