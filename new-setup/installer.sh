# shellcheck shell=bash

# Xcode
if ! xcode-select --print-path &>/dev/null; then

  # Prompt user to install the command line tools
  xcode-select --install &>/dev/null

  # Wait until the command line tools are installed
  until xcode-select --print-path &>/dev/null; do
    sleep 5
  done
  print_result $? 'Install Xcode Command Line Tools'

  # Point the `xcode-select` developer directory to
  # the appropriate directory from within `Xcode.app`
  sudo xcode-select -switch /Applications/Xcode.app/Contents/Developer
  print_result $? 'Make "xcode-select" developer directory point to Xcode'

  # Prompt user to agree to the terms of the Xcode license
  sudo xcodebuild -license
  print_result $? 'Agree with the Xcode Command Line Tools licence'

fi

# Make sure we’re using the latest Homebrew
brew update

# Upgrade any already-installed formulae
brew upgrade

# Tap additional sources for Homebrew and Cask
brew tap homebrew/cask-fonts
brew tap homebrew/cask-versions
brew tap homebrew/core
brew tap homebrew/services
brew tap burnsra/tap

# GNU core utilities (those that come with macOS are outdated)
# Don’t forget to add `$(brew --prefix coreutils)/libexec/gnubin` to `$PATH`.
brew install coreutils moreutils

# GNU `find`, `locate`, `updatedb`, and `xargs`, `g`-prefixed
brew install findutils

# GNU `sed`
brew install gnu-sed

# Bash 4 (deprecated now that zsh is the default shell)
# brew install bash bash-completion@2
# BASHPATH="$(brew --prefix)/bin/bash"
# echo $BASHPATH | sudo tee -a /etc/shells
# chsh -s $BASHPATH # will set for current user only.

# Ruby + rbenv
RBENV_VERSION=${RBENV_VERSION:-'2.7.2'}
rbenv install "$RBENV_VERSION"
rbenv global "$RBENV_VERSION"

# Generic Colorizer
brew install grc

# Install wget
brew install wget

# Install more recent versions of some macOS tools
brew install grep screen

# Install tmux and tmuxinator
brew install tmux
gem install tmuxinator

# Install Vim and Vundle
brew install vim

# Install Fira Code font
brew install --cask font-fira-code

# Node
brew install node

# Yarn
brew install yarn

# Watchman
brew install watchman

# Git
brew install git

# -- Git flow
brew install git-flow-avh

# -- GitHub utils
brew install hub

# -- Other git-related tools
brew install bash-git-prompt zsh-git-prompt diff-so-fancy

# ImageMagick
brew install imagemagick

# FFmpeg
brew install ffmpeg

# Some other useful tools
brew install \
  pv \
  rename \
  tree \
  zopfli \
  stormssh \
  gpg2

# QuickLook plugins
brew install --cask \
  qlcolorcode \
  qlmarkdown \
  quicklook-json \
  qlimagesize \
  webpquicklook \
  suspicious-package

# Browsers
brew install --cask \
  google-chrome \
  firefox \
  firefox-developer-edition

# Developer tools
brew install --cask \
  atom \
  visual-studio-code \
  dash \
  sourcetree \
  github \
  docker \
  postman \
  imagealpha \
  imageoptim \
  gpg-suite \
  spike

# Some other useful apps
brew install --cask \
  appcleaner \
  dropbox \
  slack \
  transmission \
  vlc \
  elmedia-player \
  soda-player \
  plex-media-server \
  plex \
  istat-menus \
  product-hunt \
  macdown \
  chai \
  the-unarchiver

# Pygments (allows for syntax-highlighted terminal output)
sudo easy_install -U Pygments

# Linters
brew install shellcheck

# pa11y (accessibility testing)
# npm install -g pa11y

# Install dnsmasq
# brew install dnsmasq

# -- Create config file
# mkdir -pv "$(brew --prefix)/etc/"
# tee "$(brew --prefix)/etc/dnsmasq.conf" >/dev/null <<EOF
# # WordPress Sites (VVV)
# address=/.dev/192.168.50.4
# EOF

# -- Copy & start the launch daemon
# sudo cp -v "$(brew --prefix dnsmasq)/homebrew.mxcl.dnsmasq.plist" /Library/LaunchDaemons
# sudo launchctl load -w /Library/LaunchDaemons/homebrew.mxcl.dnsmasq.plist

# -- Create resolver config file
# sudo mkdir -v /etc/resolver
# echo 'nameserver 127.0.0.1' | sudo tee /etc/resolver/dev >/dev/null
