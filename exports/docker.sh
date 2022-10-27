# shellcheck shell=bash disable=1090

function __dotfiles_exports_docker() {
  if [[ -e /var/run/docker.sock ]]; then
    export DOCKER_HOST="unix:///var/run/docker.sock"
  fi
}

__dotfiles_exports_docker
