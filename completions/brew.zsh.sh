# shellcheck shell=bash disable=1090,2206

function __dotfiles_completions_brew_zsh() {
  local -r brew_completions_dir_path="$(get-brew-prefix-path)/share/zsh/site-functions"

  if [ -d "$brew_completions_dir_path" ]; then
    fpath=($brew_completions_dir_path $fpath)
  fi
}

__dotfiles_completions_brew_zsh
