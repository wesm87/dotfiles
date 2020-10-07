# shellcheck shell=bash disable=1090

function __dotfiles_exports_dotfiles_bin_path() {
  prepend-to-path "$HOME/.dotfiles/bin"
}

__dotfiles_exports_dotfiles_bin_path
