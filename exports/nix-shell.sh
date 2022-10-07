# shellcheck shell=bash disable=1090

function __dotfiles_exports_nix_shell() {
  local nix_daemon_path="/nix/var/nix/profiles/default/etc/profile.d/nix-daemon.sh"

  if [[ -f "$nix_daemon_path" ]]; then
    source $nix_daemon_path
  fi
}

__dotfiles_exports_nix_shell
