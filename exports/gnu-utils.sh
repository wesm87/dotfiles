# shellcheck shell=bash

function gnu_utils_exports() {
  if ! is-brew-installed; then
    return
  fi

  local coreutils_base_path
  local coreutils_bin_path
  local coreutils_man_path
  local sed_base_path
  local sed_bin_path
  local sed_man_path

  coreutils_base_path="$(brew --prefix coreutils)/libexec"
  coreutils_bin_path="$coreutils_base_path/gnubin"
  coreutils_man_path="$coreutils_base_path/gnuman"

  sed_base_path="$(brew --prefix gnu-sed)/libexec"
  sed_bin_path="$sed_base_path/gnubin"
  sed_man_path="$sed_base_path/gnuman"

  # Update `$PATH`.
  export PATH="$coreutils_bin_path:$sed_bin_path:$PATH"

  # Update `$MANPATH`
  export MANPATH="$coreutils_man_path:$sed_man_path:$MANPATH"
}

gnu_utils_exports
