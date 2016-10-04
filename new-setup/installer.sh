#! /usr/bin/env bash

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

# -- Add Homebrew sources
brew tap homebrew/versions
brew tap homebrew/completions
brew tap homebrew/php

# -- Add Cask sources
brew tap caskroom/versions

# Make sure we’re using the latest Homebrew
brew update

# Upgrade any already-installed formulae
brew upgrade

# GNU core utilities (those that come with OS X are outdated)
# Don’t forget to add `$(brew --prefix coreutils)/libexec/gnubin` to `$PATH`.
brew install coreutils
brew install moreutils

# GNU `find`, `locate`, `updatedb`, and `xargs`, `g`-prefixed
brew install findutils

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
brew install vim --override-system-vi
brew install homebrew/dupes/grep
brew install homebrew/dupes/screen

# Node
brew install node

# Watchman
brew install watchman

# Git
brew install git
git config --global user.name "Wes Moberly"
git config --global user.email "wesm87@gmail.com"
git config --global credential.helper osxkeychain

# -- Git flow
brew install git-flow-avh

# -- GitHub util
brew install gh

# -- Other git-related tools
# bash < <( curl https://raw.github.com/jamiew/git-friendly/master/install.sh)
brew install bash-git-prompt
npm install -g git-open

# ImageMagick w/ WebP support
brew install imagemagick --with-webp

# FFmpeg w/ WebM and AAC support
brew install ffmpeg --with-libvpx --with-faac

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


# Install some useful apps
brew cask install \
  appcleaner \
  dropbox \
  google-drive \
  google-hangouts \
  transmission \
  vlc \
  mplayerx \
  imagealpha \
  imageoptim \
  gpgtools

# Virtualbox, Parallels Desktop, Vagrant, and Vagrant Manager
brew cask install \
  virtualbox
  parallels-desktop \
  vagrant \
  vagrant-manager

# Docker, Docker Compose
brew install docker docker-compose

# Pygments (allows for syntax-highlighted terminal output)
sudo easy_install -U Pygments

# Ruby + rbenv
echo 'gem: --no-document' > ~/.gemrc
brew install rbenv
eval "$(rbenv init -)"
RBENV_VERSION=${RBENV_VERSION:-'2.3.1'}
rbenv install $RBENV_VERSION
rbenv global $RBENV_VERSION

# Unit testing

# -- PHPUnit
brew install phpunit

# Functional testing

# -- Selenium
brew install selenium-server-standalone

# -- PhantomJS
brew install phantomjs

# Linters
gem install scss_lint
npm i -g eslint babel-eslint
brew install shellcheck

# MongoDB
brew install mongo

# PostgreSQL
brew install postgresql

# pa11y (accessibility testing)
npm install -g pa11y

# Install dnsmasq
brew install dnsmasq

# -- Create config file
mkdir -pv "$(brew --prefix)/etc/"
tee "$(brew --prefix)/etc/dnsmasq.conf" >/dev/null <<EOF
# WordPress Sites (VVV)
address=/.dev/192.168.50.4
EOF

# -- Copy & start the launch daemon
sudo cp -v "$(brew --prefix dnsmasq)/homebrew.mxcl.dnsmasq.plist" /Library/LaunchDaemons
sudo launchctl load -w /Library/LaunchDaemons/homebrew.mxcl.dnsmasq.plist

# -- Create resolver config file
sudo mkdir -v /etc/resolver
echo "nameserver 127.0.0.1" | sudo tee /etc/resolver/dev >/dev/null