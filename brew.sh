#!/bin/sh

brew update
brew upgrade

brew tap homebrew/cask

# for ricty
brew tap sanemat/font

# gitignore
brew tap toshi0607/homebrew-gig

# shell
brew install zsh-completions
brew install gnu-sed

# Utils
brew install trash
brew install wget
brew install the_silver_searcher
brew install gpg

# language management
brew install asdf

brew install ghq
brew install peco
brew install jq
brew install md5sha1sum
brew install nkf
brew install tmux
brew install reattach-to-user-namespace
brew install direnv
brew install git-secrets

brew install sourcetree --cask
brew install spectacle --cask
brew install iterm2 --cask
brew install skitch --cask
brew install slack --cask

# editor
brew install visual-studio-code --cask

# remove outdated versions.
brew cleanup
