#!/usr/bin/env bash

# Xcode
if ! xcode-select --print-path &> /dev/null; then

  # Prompt user to install the command line tools
  xcode-select --install &> /dev/null

  # Wait until the command line tools are installed
  until xcode-select --print-path &> /dev/null; do
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

# Install Homebrew if it's not already installed
if ! [ "$(which brew)" ]; then
  /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
fi

# Make sure we’re using the latest Homebrew
brew update

# Upgrade any already-installed formulae
brew upgrade

# Tap additional sources for Homebrew and Cask
brew tap \
  caskroom/cask \
  caskroom/fonts \
  caskroom/versions \
  homebrew/completions \
  homebrew/core \
  homebrew/dupes \
  homebrew/php \
  homebrew/services

# GNU core utilities (those that come with OS X are outdated)
# Don’t forget to add `$(brew --prefix coreutils)/libexec/gnubin` to `$PATH`.
brew install coreutils
brew install moreutils

# GNU `find`, `locate`, `updatedb`, and `xargs`, `g`-prefixed
brew install findutils

# GNU `sed`
brew install gnu-sed

# Bash 4
brew install bash
brew install bash-completion2
brew install brew-cask-completion

BASHPATH="$(brew --prefix)/bin/bash"
echo $BASHPATH | sudo tee -a /etc/shells
chsh -s $BASHPATH # will set for current user only.

# Generic Colorizer
brew install grc

# Install wget with IRI support
brew install wget --with-iri

# Install more recent versions of some OS X tools
brew install homebrew/dupes/grep
brew install homebrew/dupes/screen

# Install tmux and tmuxinator
brew install tmux
gem install tmuxinator

# Install Vim and Vundle
brew install vim --with-override-system-vi
if ! [ -f "$HOME/.vim/bundle/Vundle.vim" ]; then
  git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim
fi

# Install Fira Code font
brew cask install font-fira-code

# Node
brew install node

# Yarn
brew install yarn

# Watchman
brew install watchman

# Git
brew install git
git config --global user.name 'Wes Moberly'
git config --global user.email 'github.wes@mailhero.io'
git config --global credential.helper osxkeychain

# -- Git flow
brew install git-flow-avh

# -- GitHub utils
brew install hub

# -- Other git-related tools
brew install bash-git-prompt

# ImageMagick w/ WebP support
brew install imagemagick --with-webp

# FFmpeg w/ WebM and AAC support
brew install ffmpeg \
  --with-libvpx \
  --with-fdk-aac \
  --with-x265 \
  --with-tools \
  --with-freetype \
  --with-libass

# Some other useful tools
brew install \
  pv \
  rename \
  tree \
  zopfli

# QuickLook plugins
brew cask install \
  qlcolorcode \
  qlstephen \
  qlmarkdown \
  quicklook-json \
  qlimagesize \
  webpquicklook \
  suspicious-package

# Browsers
brew cask install \
  google-chrome \
  firefox \
  caskroom/versions/firefoxdeveloperedition

# Developer tools
brew cask install \
  atom \
  dash \
  sourcetree \
  github \
  docker \
  postman \
  imagealpha \
  imageoptim \
  gpgtools

# Some other useful apps
brew cask install \
  appcleaner \
  dropbox \
  slack \
  transmission \
  vlc \
  mplayerx \
  soda-player \
  istat-menus \
  product-hunt \
  macdown \
  kaomoji

# Pygments (allows for syntax-highlighted terminal output)
sudo easy_install -U Pygments

# Ruby + rbenv
echo 'gem: --no-document' > ~/.gemrc
brew install rbenv
eval "$(rbenv init -)"
RBENV_VERSION=${RBENV_VERSION:-'2.4.2'}
rbenv install $RBENV_VERSION
rbenv global $RBENV_VERSION

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
