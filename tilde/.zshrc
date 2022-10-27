# shellcheck shell=bash

# shellcheck source=profile.zsh.sh
source "${HOME}/.dotfiles/profile.zsh.sh"

function __dotfiles_zshrc() {
  export HISTFILE="${HOME}/.dotfiles/data/zhistory"
  export HISTSIZE='50000'
  export SAVEHIST="$HISTSIZE"
  export HISTFILESIZE="$HISTSIZE"

  setopt EXTENDED_HISTORY
  setopt INC_APPEND_HISTORY
  setopt HIST_VERIFY
  setopt HIST_IGNORE_DUPS
  setopt HIST_IGNORE_SPACE
  setopt HIST_REDUCE_BLANKS

  # Kill backwards rather than the whole line
  bindkey '^U' backward-kill-line

  # Shift-tab to cycle back through menus
  bindkey '^[[Z' reverse-menu-complete

  # Fix broken alt key on macOS
  bindkey '∫' backward-word
  bindkey 'ƒ' forward-word

  # Fix fn-backspace on macOS
  bindkey '^[[3~' delete-char

  # Allow comments in interactive shells
  setopt interactive_comments

  # Add more word separators
  export WORDCHARS=${WORDCHARS//[\/.-]/}

  # Auto-escape URLs
  autoload -Uz url-quote-magic
  zle -N self-insert url-quote-magic

  # Better file renaming
  autoload -U zmv

  autoload -Uz compinit && compinit

  zstyle ':completion:*' use-cache on
  zstyle ':completion:*' cache-path "${HOME}/.dotfiles/data/cache/zsh-completions"

  # THIS MUST BE AT THE END OF THE FILE FOR SDKMAN TO WORK!!!
  local -r sdkman_init_script_path="${SDKMAN_DIR}/bin/sdkman-init.sh"

  if [[ -s "$sdkman_init_script_path" ]]; then
    # shellcheck source=~/.sdkman/bin/sdkman-init.sh disable=1090
    source "$sdkman_init_script_path"
  fi
}

__dotfiles_zshrc
