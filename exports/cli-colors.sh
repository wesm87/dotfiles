# shellcheck shell=bash

function __dotfiles_cli_colors_exports() {
  # Always use colors, even when piping (to `awk`, `grep`, etc).
  export CLICOLOR_FORCE=1

  # `ls` colors
  export LS_COLORS="$LS_COLORS:ow=1;4;34:tw=1;4;34:"

  # Directory colors.
  if [ -x /usr/bin/dircolors ]; then
    if [ -r ~/.dircolors ]; then
      eval "$(dircolors -b ~/.dircolors)"
    else
      eval "$(dircolors -b)"
    fi
  fi
}

__dotfiles_cli_colors_exports
