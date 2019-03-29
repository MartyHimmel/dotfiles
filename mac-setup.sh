#!/usr/bin/env bash

DOTFILES_DIR=$PWD

echo "Setting up .bash_profile"
cp $DOTFILES_DIR/.bash_profile ~/.bash_profile
source ~/.bash_profile
echo "Done"

cd ~

echo "Installing xcode"
xcode-select --install
echo "Done"

if [ -n $(which brew) ]
then
    echo "Homebrew is already installed - updating"
    brew update
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
echo "Done installing core utilities"

echo "Installing browsers"
brew cask install firefox
brew cask install google-chrome
brew cask install tor-browser
echo "Done installing browsers"

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
brew install dnsmasq
echo "Done installing dev tools"

echo "Setting up Sublime Text"
cp $DOTFILES_DIR/SublimeText/Preferences.sublime-settings "~/Library/Application Support/Sublime Text 3/Packages/User/Preferences.sublime-settings"
ln -s "/Application/Sublime Text.app/Contents/SharedSupport/bin/subl" /usr/local/bin/sublime
echo "Done setting up Sublime Text"

echo "Setting up .test environment for web development"
cd $(brew --prefix); mkdir etc; echo 'address=/.test/127.0.0.1' > etc/dnsmasq.conf
sudo cp -v $(brew --prefix dnsmasq)/homebrew.mxcl.dnsmasq.plist /Library/LaunchDaemons
sudo launchctl load -w /Library/LaunchDaemons/homebrew.mxcl.dnsmasq.plist
sudo mkdir /etc/resolver
sudo bash -c 'echo "nameserver 127.0.0.1" > /etc/resolver/test'
cd ~
mkdir www
echo "Done setting up web dev environment"

echo "Setting up rbenv"
rbenv init
echo "Done setting up rbenv"

echo "Installing design tools"
brew cask install gimp
brew cask install aseprite
echo "Done installing design tools"

echo "Cleaning up"
brew cleanup

cd $DOTFILES_DIR

echo "Setup is complete! Restart the shell to make sure all changes are in effect."
