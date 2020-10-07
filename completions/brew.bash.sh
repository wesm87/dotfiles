# shellcheck shell=bash disable=1090

function __dotfiles_brew_completions_bash() {
  local brew_prefix
  local brew_completions_file_path
  local brew_completions_compat_dir_path

  brew_prefix="$(get-brew-prefix-path)"
  brew_completions_file_path="${brew_prefix}/etc/profile.d/bash_completion.sh"
  brew_completions_compat_dir_path="${brew_prefix}/etc/bash_completion.d"

  if [ -d "$brew_prefix" ]; then
    if can-source-file "$brew_completions_file_path"; then
      export BASH_COMPLETIONs_COMPAT_DIR="$brew_completions_compat_dir_path"
      source "$brew_completions_file_path"
    elif [ -d "$brew_completions_compat_dir_path" ]; then
      for completions_file in "${brew_completions_compat_dir_path}/"*; do
        can-source-file "$completions_file" && source "$completions_file"
      done
    fi
  fi
}

__dotfiles_brew_completions_bash
