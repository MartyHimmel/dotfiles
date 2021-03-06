#!/usr/bin/env bash

DOTFILES_DIR=$PWD

cd ~

echo "Installing xcode"
xcode-select --install
echo "Done"

if [ -n $(which brew) ]
then
    echo "Homebrew is already installed - updating"
    brew update
    echo "Done updating Homebrew"
else
    echo "Installing Homebrew"
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh)"
    echo "Finished installing Homebrew"
fi

echo "Installing core utilities"
brew install coreutils
brew install wget
brew install screen
brew install grep
brew install tree
echo "Done installing core utilities"

echo "Installing browsers"
brew cask install firefox
brew cask install google-chrome
brew cask install tor-browser
echo "Done installing browsers"

echo "Installing dev tools"
brew cask install iterm2
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
brew install yarn
brew install composer
brew install dnsmasq
brew install eslint
echo "Done installing dev tools"

echo "Setting up Sublime Text"
if [ ! -d ~/Library/Application\ Support/Sublime\ Text\ 3/Packages/User ]
then
	mkdir ~/Library/Application\ Support/Sublime\ Text\ 3/Packages/User
fi

for sublime_file in "$DOTFILES_DIR/SublimeText"/*
do
    file_name=$(basename "$sublime_file")
    copy_destination=~/Library/Application\ Support/Sublime\ Text\ 3/Packages/User/"$file_name"
    cp "$sublime_file" "$copy_destination"
done
ln -s "/Applications/Sublime Text.app/Contents/SharedSupport/bin/subl" /usr/local/bin/sublime
echo "Done setting up Sublime Text"

echo "Setting up .test environment for web development"
cd $(brew --prefix); mkdir etc; echo 'address=/.test/127.0.0.1' > etc/dnsmasq.conf
sudo cp -v $(brew --prefix dnsmasq)/homebrew.mxcl.dnsmasq.plist /Library/LaunchDaemons
sudo launchctl load -w /Library/LaunchDaemons/homebrew.mxcl.dnsmasq.plist
sudo mkdir /etc/resolver
sudo bash -c 'echo "nameserver 127.0.0.1" > /etc/resolver/test'
cd ~
mkdir www
echo "Done setting up .test web dev environment"

echo "Setting up rbenv"
rbenv init
echo "Done setting up rbenv"

echo "Installing design tools"
brew cask install gimp
brew cask install aseprite
echo "Done installing design tools"

echo "Installing other programs"
brew cask install adobe-acrobat-reader
brew cask install teamviewer
brew cask install obs
brew cask install dropbox
brew cask install spotify
brew cask install slack
brew cask install discord
echo "Done"

echo "Installing custom fonts"
brew tap homebrew/cask-fonts
brew cask install font-fira-code
brew cask install font-fira-mono-for-powerline
echo "Done install fonts"

echo "Installing Oh My Zsh"
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

git clone https://github.com/denysdovhan/spaceship-prompt.git "$ZSH_CUSTOM/themes/spaceship-prompt"
ln -s "$ZSH_CUSTOM/themes/spaceship-prompt/spaceship.zsh-theme" "$ZSH_CUSTOM/themes/spaceship.zsh-theme"
sed -i.bak 's/ZSH_THEME="\([^"]*\)"/ZSH_THEME="spaceship"/' ~/.zshrc

git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting
sed -i "" 's/plugins=(\([^)]*\))/plugins=(git osx zsh-syntax-highlighting)/' ~/.zshrc

cat "$DOTFILES_DIR/.includes" >> ~/.zshrc
echo "Done installing Oh My Zsh"

source ~/.zshrc

echo "Cleaning up installation files"
brew cleanup

echo "Setting up mariadb"
# cleanup removes a folder required for mariadb
mkdir /usr/local/etc/my.cnf.d
sudo mysql_secure_installation
echo "Done setting up mariadb"

cd $DOTFILES_DIR

echo "Setup is complete! Restart the shell to make sure all changes are in effect."
