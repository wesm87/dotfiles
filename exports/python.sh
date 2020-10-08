# shellcheck shell=bash disable=1090

function __dotfiles_exports_python() {
  local -r python_prefix_path="$(get-brew-prefix-path python)"
  local -r python_versioned_bin_path="${python_prefix_path}/bin"
  local -r python_non_versioned_bin_path="${python_prefix_path}/libexec/bin"
}

__dotfiles_exports_python
