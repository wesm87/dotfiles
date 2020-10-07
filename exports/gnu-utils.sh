# shellcheck shell=bash

function __dotfiles_gnu_utils_exports() {
  if ! is-command brew; then
    return
  fi

  local -r coreutils_base_path="$(get-brew-prefix-path coreutils)/libexec"
  local -r sed_base_path="$(get-brew-prefix-path gnu-sed)/libexec"

  # Update `$PATH`.
  prepend-to-path "$sed_base_path/gnubin"
  prepend-to-path "$coreutils_base_path/gnubin"

  # Update `$MANPATH`
  prepend-to-manpath "$sed_base_path/gnuman"
  prepend-to-manpath "$coreutils_base_path/gnuman"
}

__dotfiles_gnu_utils_exports
