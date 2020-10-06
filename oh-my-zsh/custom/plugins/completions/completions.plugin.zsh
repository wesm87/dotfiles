# shellcheck shell=bash disable=1090,2206

function __dotfiles_completions() {
  local -r lib_dir_path="${ZSH_CUSTOM}/plugins/completions/lib"

  for file in "$lib_dir_path"/*.sh; do
    source "$file"
  done
}

__dotfiles_completions
