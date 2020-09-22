# shellcheck disable=1090

function _dotfiles_bash_completions() {
  local brew_prefix
  local custom_completions_dir

  if ! is-brew-installed; then
    return
  fi

  brew_prefix="$(brew --prefix)"
  custom_completions_dir="$HOME/.dotfiles/completions"

  # -- Git
  . "$custom_completions_dir/git-completion.bash"

  if [[ -r "${brew_prefix}/etc/profile.d/bash_completion.sh" ]]; then
    export BASH_COMPLETION_COMPAT_DIR="$brew_prefix/etc/bash_completion.d"
    . "${brew_prefix}/etc/profile.d/bash_completion.sh"
  else
    for COMPLETION in "${brew_prefix}/etc/bash_completion.d/"*; do
      [[ -r "$COMPLETION" ]] && . "$COMPLETION"
    done
  fi
}

_dotfiles_bash_completions
