# shellcheck shell=bash disable=1090

function __dotfiles_bash_completions() {
  # Bail if this is a non-interactive shell
  if shopt -oq posix; then
    return
  fi

  local -r dotfiles_completions_dir_path="${HOME}/.dotfiles/completions"

  # -- Load completions from `./completions`
  if [ -d "$dotfiles_completions_dir_path" ]; then
    for completion_file in "${dotfiles_completions_dir_path}/"*.bash.sh; do
      can-source-file "$completion_file" && source "$completion_file"
    done
  fi
}

__dotfiles_bash_completions
