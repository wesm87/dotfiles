# shellcheck shell=bash

function __dotfiles_gnu_utils_exports() {
  if ! is-command brew; then
    return
  fi

  local coreutils_base_path
  local sed_base_path

  coreutils_base_path="$(get-brew-prefix-path coreutils)/libexec"
  sed_base_path="$(get-brew-prefix-path gnu-sed)/libexec"

  # Update `$PATH`.
  prepend-to-path "$sed_base_path/gnubin"
  prepend-to-path "$coreutils_base_path/gnubin"

  # Update `$MANPATH`
  prepend-to-path "$sed_base_path/gnuman"
  prepend-to-path "$coreutils_base_path/gnuman"
}

__dotfiles_gnu_utils_exports
