# shellcheck shell=bash
# shellcheck disable=1090

function _dotfiles_bash_completions() {
  local brew_prefix
  local custom_completions_dir_path
  local bash_completion_file_path
  local bash_completion_compat_dir_path

  if ! is-brew-installed; then
    return
  fi

  brew_prefix="$(brew --prefix)"
  custom_completions_dir_path="${HOME}/.dotfiles/completions"
  bash_completion_file_path="${brew_prefix}/etc/profile.d/bash_completion.sh"
  bash_completion_compat_dir_path="${brew_prefix}/etc/bash_completion.d"

  # -- Git
  . "$custom_completions_dir_path/git-completion.bash"

  if [ -r "$bash_completion_file_path" ]; then
    export BASH_COMPLETION_COMPAT_DIR="$bash_completion_compat_dir_path"
    source "$bash_completion_file_path"
  else
    for COMPLETION in "$bash_completion_compat_dir_path/"*; do
      [ -r "$COMPLETION" ] && . "$COMPLETION"
    done
  fi
}

_dotfiles_bash_completions
