# shellcheck disable=1090

NVM_DIR="$HOME/.nvm"
export NVM_DIR

if [ ! -d "$NVM_DIR" ]; then
  curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.35.3/install.sh | bash
fi

# npm config delete prefix

source "$NVM_DIR/nvm.sh"