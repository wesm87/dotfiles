# shellcheck shell=bash disable=1090,2128,2207

# Complete ssh with hosts in ~/.ssh/config
function __dotfiles_completions_ssh_zsh() {
  zstyle -s ':completion:*:hosts' hosts _ssh_config

  if [[ -r ~/.ssh/config ]]; then
    _ssh_config+=($(grep -v '\*' ~/.ssh/config | sed -ne 's/Host[=\t ]//p'))
  fi

  # shellcheck disable=2086
  zstyle ':completion:*:hosts' hosts $_ssh_config
}

__dotfiles_completions_ssh_zsh
