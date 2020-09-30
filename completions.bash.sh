# shellcheck shell=bash
# shellcheck disable=1090

function _dotfiles_bash_completions() {
  local brew_prefix
  local dotfiles_completions_dir_path
  local bash_completion_file_path
  local bash_completion_compat_dir_path

  # Bail if this is a non-interactive shell
  if shopt -oq posix; then
    return
  fi

  brew_prefix="$(get-brew-prefix-path)"
  dotfiles_completions_dir_path="${HOME}/.dotfiles/completions"

  if [ -d "$dotfiles_completions_dir_path" ]; then
    # -- Custom completions from `~/.dotfiles/completions`
    for completion_file in "$dotfiles_completions_dir_path/"*; do
      [ -r "$completion_file" ] && source "$completion_file"
    done
  fi

  if [ -d "$brew_prefix" ]; then
    # -- Homebrew-installed completions on macOS
    bash_completion_file_path="${brew_prefix}/etc/profile.d/bash_completion.sh"
    bash_completion_compat_dir_path="${brew_prefix}/etc/bash_completion.d"

    if [ -r "$bash_completion_file_path" ]; then
      export BASH_COMPLETION_COMPAT_DIR="$bash_completion_compat_dir_path"
      source "$bash_completion_file_path"
    elif [ -d "$bash_completion_compat_dir_path" ]; then
      for COMPLETION in "$bash_completion_compat_dir_path/"*; do
        [ -r "$COMPLETION" ] && source "$COMPLETION"
      done
    fi
  else
    # -- Ubuntu completions
    bash_completion_file_path='/usr/share/bash-completion/bash_completion'

    if [ -f "$bash_completion_file_path" ]; then
      source "$bash_completion_file_path"
    elif [ -f /etc/bash_completion ]; then
      source /etc/bash_completion
    fi
  fi
}

_dotfiles_bash_completions
