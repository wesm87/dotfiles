# shellcheck shell=bash

# If not running interactively, don't do anything
case $- in
*i*) ;;
*) return ;;
esac

# shellcheck source=./profile.bash.sh
__DOTFILES_IS_BASH_RC='true' source "${HOME}/.dotfiles/profile.bash.sh"

function __dotfiles_bashrc() {
  # append to the history file, don't overwrite it
  shopt -s histappend

  # don't put duplicate lines or lines starting with space in the history.
  # See bash(1) for more options
  HISTCONTROL=ignoreboth

  # for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
  HISTSIZE=1000
  HISTFILESIZE=2000

  # check the window size after each command and, if necessary,
  # update the values of LINES and COLUMNS.
  shopt -s checkwinsize

  # If set, the pattern "**" used in a pathname expansion context will
  # match all files and zero or more directories and subdirectories.
  #shopt -s globstar

  # make less more friendly for non-text input files, see lesspipe(1)
  [ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

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
