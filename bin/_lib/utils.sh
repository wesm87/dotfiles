# shellcheck shell=bash disable=1090

source "${HOME}/.dotfiles/functions/logging.sh"

function __log_message() {
  local message_type="$1"
  local message_text="$2"
  local should_bookend_flag="${3:-}"
  local message_function_name="_${message_type}"

  [ "$should_bookend_flag" = '--bookend' ] && message_function_name="${message_function_name}_"

  "$message_function_name" "$message_text"
}

function __log_command_message() {
  local message_type="$1"
  local command_name="$2"
  local message_text="$3"
  local should_bookend_flag="${4:-}"

  __log_message "$message_type" "[${command_name}]: ${message_text}" "$should_bookend_flag"
}

function __log_command_error() {
  __log_command_message 'error' "$@"
}

function __validate_is_supported_os() {
  local command_name="$1"

  if ! is-mac-os && ! is-linux-os; then
    __log_command_error "$command_name" 'only macOS and Linux are supported'
    exit 1
  fi
}
