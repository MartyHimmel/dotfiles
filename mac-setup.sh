#!/usr/bin/env bash

echo "Copying .bash_profile"
cp ./.bash_profile ~/.bash_profile

echo "Copying Sublime Text preferences"
cp ./SublimeText/Preferences.sublime-settings ~/Library/Application Support/Sublime Text 3/Packages/User/Preferences.sublime-settings

echo "Sourcing .bash_profile"
source ~/.bash_profile

if [ -n $(which brew) ]
then
    echo "Homebrew is already installed"
else
    echo "Installing Homebrew"
    /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
    echo "Finished installing Homebrew"
fi

echo "All set!"
