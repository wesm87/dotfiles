# shellcheck shell=bash disable=1090

function __dotfiles_completions_zsh() {
  local -r dotfiles_completions_dir_path="${HOME}/.dotfiles/completions"

  # -- Load completions from `./completions`
  if [ -d "$dotfiles_completions_dir_path" ]; then
    for completion_file in "${dotfiles_completions_dir_path}/"*.zsh.sh; do
      can-source-file "$completion_file" && source "$completion_file"
    done
  fi
}

__dotfiles_completions_zsh
