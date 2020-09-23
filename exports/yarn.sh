# shellcheck shell=bash

function yarn_exports() {
  local yarn_global_bin_path

  yarn_global_bin_path="$(yarn global bin 2>/dev/null)"

  export PATH="$PATH:$yarn_global_bin_path"
}

yarn_exports
