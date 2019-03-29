#!/usr/bin/env bash

DOTFILES_DIR=$PWD

echo "Setting up .bash_profile"
cp $DOTFILES_DIR/.bash_profile ~/.bash_profile
source ~/.bash_profile
echo "Done"

cd ~

echo "Installing xcode"
xcode-select --install

if [ -n $(which brew) ]
then
    echo "Homebrew is already installed"
else
    echo "Installing Homebrew"
    /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
    echo "Finished installing Homebrew"
fi

echo "Installing core utilities"
brew install coreutils
brew install wget
brew install screen
brew install grep

echo "Installing browsers"
brew cask install firefox
brew cask install google-chrome
brew cask install tor-browser

echo "Installing dev tools"
brew cask install sublime-text
brew cask install visual-studio-code
brew cask install postman
brew install php
brew install php-cs-fixer
brew install phpunit
brew install mariadb
brew install phpmyadmin
brew install rbenv
brew install node
brew install composer

echo "Setting up Sublime Text"
cp $DOTFILES_DIR/SublimeText/Preferences.sublime-settings "~/Library/Application Support/Sublime Text 3/Packages/User/Preferences.sublime-settings"
ln -s "/Application/Sublime Text.app/Contents/SharedSupport/bin/subl" /usr/local/bin/sublime

echo "Setting up rbenv"
rbenv init

echo "Installing design tools"
brew cask install gimp
brew cask install aseprite

echo "Cleaning up"
brew cleanup

cd $DOTFILES_DIR

echo "Setup is complete! Restart the shell to make sure all changes are in effect."
