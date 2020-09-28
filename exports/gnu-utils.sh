# shellcheck shell=bash

function __dotfiles_gnu_utils_exports() {
  if ! is-command brew; then
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
  if ! string-contains "$sed_bin_path" "$PATH"; then
    export PATH="$sed_bin_path:$PATH"
  fi
  if ! string-contains "$coreutils_bin_path" "$PATH"; then
    export PATH="$coreutils_bin_path:$PATH"
  fi

  # Update `$MANPATH`
  if ! string-contains "$sed_man_path" "$MANPATH"; then
    export MANPATH="$sed_man_path:$MANPATH"
  fi
  if ! string-contains "$coreutils_man_path" "$MANPATH"; then
    export MANPATH="$coreutils_man_path:$PATH"
  fi
}

__dotfiles_gnu_utils_exports
