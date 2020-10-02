# shellcheck shell=bash disable=1090

function _dotfiles_zsh_completions() {
  # Bail if this is a non-interactive shell
  if shopt -oq posix; then
    return
  fi

  dotfiles_completions_dir_path="$HOME/.dotfiles/completions"

  # -- Load completions from `./completions`
  if [ -d "$dotfiles_completions_dir_path" ]; then
    for completion_file in "$dotfiles_completions_dir_path/"*.zsh.sh; do
      can-source-file "$completion_file" && source "$completion_file"
    done
  fi
}

_dotfiles_zsh_completions
