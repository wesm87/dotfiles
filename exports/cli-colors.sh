# shellcheck shell=bash

function __dotfiles_cli_colors_exports() {
  # always use color, even when piping (to awk,grep,etc)
  export CLICOLOR_FORCE=1
}

__dotfiles_cli_colors_exports
