# shellcheck shell=bash disable=1090,2206

function __dotfiles_brew_completions_zsh() {
  local brew_completions_dir_path

  brew_completions_dir_path="$(get-brew-prefix-path)/share/zsh/site-functions"

  if [ -d "$brew_completions_dir_path" ]; then
    fpath=($brew_completions_dir_path $fpath)
  fi
}

__dotfiles_brew_completions_zsh
