# shellcheck shell=bash

# If not running interactively, don't do anything
case $- in
*i*) ;;
*) return ;;
esac

# shellcheck source=./profile.bash.sh
__DOTFILES_IS_BASH_RC='true' source "${HOME}/.dotfiles/profile.bash.sh"

function __dotfiles_bashrc() {
  local -r history_dir_path="${HOME}/.dotfiles/data/history"

  if [ -n "$NIX_STORE" ]; then
    export HISTFILE="${history_dir_path}/nix"
  else
    export HISTFILE="${history_dir_path}/bash"
  fi

  export HISTSIZE="50000"
  export SAVEHIST="$HISTSIZE"
  export HISTFILESIZE="$HISTSIZE"

  # append to the history file, don't overwrite it
  shopt -s histappend

  # don't put duplicate lines or lines starting with space in the history.
  # See bash(1) for more options
  HISTCONTROL=ignoreboth

  # check the window size after each command and, if necessary,
  # update the values of LINES and COLUMNS.
  shopt -s checkwinsize

  # If set, the pattern "**" used in a pathname expansion context will
  # match all files and zero or more directories and subdirectories.
  #shopt -s globstar

  # make less more friendly for non-text input files, see lesspipe(1)
  if [ -x /usr/bin/lesspipe ]; then
    eval "$(SHELL=/bin/sh lesspipe)"
  fi

  # Add an "alert" alias for long running commands.  Use like so:
  #   sleep 10; alert
  alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history | tail -n1 | sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'

  # THIS MUST BE AT THE END OF THE FILE FOR SDKMAN TO WORK!!!
  local -r sdkman_init_script_path="${SDKMAN_DIR}/bin/sdkman-init.sh"

  if [[ -s "$sdkman_init_script_path" ]]; then
    # shellcheck source=~/.sdkman/bin/sdkman-init.sh disable=1090
    source "$sdkman_init_script_path"
  fi
}

__dotfiles_bashrc
