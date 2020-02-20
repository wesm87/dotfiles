#!/usr/bin/env bash
# shellcheck disable=2155

COLOR_ERROR='\033[31m'   # red
COLOR_WARN='\033[33m'    # yellow
COLOR_INFO='\033[0;32m'  # green
COLOR_LOG='\033[36m'     # blue
COLOR_DEBUG='\033[0;34m' # indigo
COLOR_SPECIAL='\033[35m' # violet
COLOR_RESET='\033[0m'

NUM_COLS=$(tput cols)

function _color() {
  local color_code="${1:-}"
  local message="${2:-}"

  echo -e "${color_code}${message}${COLOR_RESET}"
}

function repeat_text() {
  local text_to_repeat="${1}"
  local eval_code="echo {1..${2}}"
  local reps_range="$(eval ${eval_code})"

  printf "${text_to_repeat}"'%.s' $reps_range
}

function _bookend_() {
  local message_prefix="[ "
  local message_suffix=" ]"
  local message="${message_prefix}${1}${message_suffix}"
  local message_chars=${#message}
  local diff=$((${NUM_COLS}-${message_chars}))

  echo "${message}$(repeat_text '–' ${diff})"
}

function _error() {
  echo "$(_color $COLOR_ERROR "$1")"
}

function _error_() {
  echo "$(_error "$(_bookend_ "$1")")"
}

function _warn() {
  echo "$(_color $COLOR_WARN "$1")"
}

function _warn_() {
  echo "$(_warn "$(_bookend_ "$1")")"
}

function _info() {
  echo "$(_color $COLOR_INFO "$1")"
}

function _info_() {
  echo "$(_info "$(_bookend_ "$1")")"
}

function _debug() {
  echo "$(_color $COLOR_DEBUG "$1")"
}

function _debug_() {
  echo "$(_debug "$(_bookend_ "$1")")"
}

function _log() {
  echo "$(_color $COLOR_LOG "$1")"
}

function _log_() {
  echo "$(_log "$(_bookend_ "$1")")"
}

function _special() {
  echo "$(_color $COLOR_SPECIAL "$1")"
}

function _special_() {
  echo "$(_special "$(_bookend_ "$1")")"
}

function oops() {
  _error_ 'OOPS:'

  while [[ -n "$1" ]]; do
    _error "$1"
    shift
  done

  _error

  return 0
}