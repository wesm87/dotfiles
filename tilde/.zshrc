# shellcheck shell=bash disable=1090

source "${HOME}/.dotfiles/profile.zsh.sh"

function __dotfiles_zshrc() {
  export HISTSIZE='50000'
  export SAVEHIST="$HISTSIZE"

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

  # Fix broken alt key on OS X
  bindkey '∫' backward-word
  bindkey 'ƒ' forward-word

  # Fix fn-backspace on OS X
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
}

__dotfiles_zshrc
