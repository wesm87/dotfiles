# shellcheck shell=bash disable=1090

function __dotfiles_exports_brew() {
  if is-linux-os; then
    local -r brew_dir_path="${HOMEBREW_PREFIX:-/home/linuxbrew/.linuxbrew}"
    local -r brew_env_output=$("${brew_dir_path}/bin/brew" shellenv)

    eval "$brew_env_output"
  fi
}

__dotfiles_exports_brew
