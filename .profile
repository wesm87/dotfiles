# shellcheck disable=1090

# Increase the max number of files that can be open at once
# ulimit -n 65536 65536 &>/dev/null

if [ -n "$BASH" ]; then
  source "$HOME/.dotfiles/.profile.bash"
fi

if [ -n "$ZSH_NAME" ]; then
  source "$HOME/.dotfiles/.profile.zsh"
fi
