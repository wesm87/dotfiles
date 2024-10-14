# shellcheck shell=bash disable=1090

function __dotfiles_exports_mysql() {
  prepend-to-path "/opt/homebrew/opt/mysql@8.0/bin"
}

__dotfiles_exports_mysql
