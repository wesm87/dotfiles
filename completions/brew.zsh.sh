# shellcheck shell=bash disable=1090

function __dotfiles_brew_completions_zsh() {
  local brew_completions_dir_path

  brew_completions_dir_path="$(get-brew-prefix-path)/share/zsh/site-functions"

  if is-command brew && [ -d "$brew_completions_dir_path" ]; then
    FPATH="$brew_completions_dir_path:$FPATH"

    echo "$FPATH"

    autoload -Uz compinit
    compinit
  fi
}

__dotfiles_brew_completions_zsh
