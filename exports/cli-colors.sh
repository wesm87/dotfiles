# shellcheck shell=bash

function cli_colors_exports() {
  # always use color, even when piping (to awk,grep,etc)
  export CLICOLOR_FORCE=1
}

cli_colors_exports
