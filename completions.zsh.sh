# shellcheck shell=bash disable=1090

function __dotfiles_completions_zsh() {
  local -r dotfiles_completions_dir_path="${HOME}/.dotfiles/completions"

  # Bail if completions folder doesn't exist
  if ! [ -d "$dotfiles_completions_dir_path" ]; then
    return
  fi

  # Load completions
  for completion_file in "${dotfiles_completions_dir_path}/"*.zsh.sh; do
    if can-source-file "$completion_file"; then
      source "$completion_file"
    fi
  done
}

__dotfiles_completions_zsh
