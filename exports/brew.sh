# shellcheck shell=bash disable=1090

function __dotfiles_exports_brew() {
  local brew_dir_path
  local brew_exec_path
  local brew_env_output

  if is-linux-os; then
    brew_dir_path="${HOMEBREW_PREFIX:-/home/linuxbrew/.linuxbrew}"
  else
    brew_dir_path="${HOMEBREW_PREFIX:-/usr/local}"
  fi

  brew_exec_path="${brew_dir_path}/bin/brew"

  if [ -f "$brew_exec_path" ]; then
    brew_env_output=$("$brew_exec_path" shellenv)
    eval "$brew_env_output"
  fi
}

__dotfiles_exports_brew
