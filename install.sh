#!/bin/sh

INSTALLDIR=$PWD

echo "---------------------------------------------------------"
echo "$(tput setaf 2)Checking for Homebrew installation.$(tput sgr 0)"
echo "---------------------------------------------------------"
brew="/usr/local/bin/brew"
if [ -f "$brew" ]
then
  echo "---------------------------------------------------------"
  echo "$(tput setaf 2)Homebrew is installed.$(tput sgr 0)"
  echo "---------------------------------------------------------"
else
  echo "--------------------------------------------------------"
  echo "$(tput setaf 3)Installing Homebrew. Homebrew requires osx command lines tools, please download xcode first$(tput sgr 0)"
  echo "---------------------------------------------------------"
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh)"
fi

echo "---------------------------------------------------------"
echo "$(tput setaf 2)Installing system packages.$(tput sgr 0)"
echo "---------------------------------------------------------"

packages=(
  "awscli"
  "bat"
  "coreutils"
  "curl"
  "diff-so-fancy"
  "fd"
  "fzf"
  "git"
  "htop"
  "jq"
  "mtr"
  "ncdu"
  "neovim"
  "node"
  "python3"
  "ripgrep"
  "tmux"
  "w3m"
  "watch"
  "z"
  "zsh"
)

for i in "${packages[@]}"
do
  brew install $i
  echo "---------------------------------------------------------"
done

echo "---------------------------------------------------------"
echo "$(tput setaf 2)Installing nvm and yarn.$(tput sgr 0)"
echo "---------------------------------------------------------"

curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.35.3/install.sh | bash
curl -o- -L https://yarnpkg.com/install.sh | bash

echo "---------------------------------------------------------"
echo "$(tput setaf 2)Installing Python NeoVim client.$(tput sgr 0)"
echo "---------------------------------------------------------"

pip3 install neovim

echo "---------------------------------------------------------"
echo "$(tput setaf 2)Installing node neovim package$(tput sgr 0)"
echo "---------------------------------------------------------"

npm install -g neovim

echo "---------------------------------------------------------"
echo "$(tput setaf 2)Installing pure prompt$(tput sgr 0)"
echo "---------------------------------------------------------"

npm install -g pure-prompt

echo "---------------------------------------------------------"
echo "$(tput setaf 2)Installing system fonts.$(tput sgr 0)"
echo "---------------------------------------------------------"

brew tap homebrew/cask-fonts
brew cask install font-fira-code

echo "---------------------------------------------------------"
echo "$(tput setaf 2)Installing oh-my-zsh.$(tput sgr 0)"
echo "---------------------------------------------------------"

if [ ! -d "$HOME/.oh-my-zsh" ]; then
  sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
else
  echo "---------------------------------------------------------"
  echo "$(tput setaf 2)oh-my-zsh already installed.$(tput sgr 0)"
  echo "---------------------------------------------------------"
fi

echo "---------------------------------------------------------"
echo "$(tput setaf 2)Installing zsh-autosuggestions.$(tput sgr 0)"
echo "---------------------------------------------------------"
git clone https://github.com/zsh-users/zsh-autosuggestions ~/.zsh/zsh-autosuggestions

echo "---------------------------------------------------------"
echo "$(tput setaf 2)Installing tmux plugin manager.$(tput sgr 0)"
echo "---------------------------------------------------------"

if [ ! -d "$HOME/.tmux/plugins/tpm" ]; then
  git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
  ~/.tmux/plugins/tpm/scripts/install_plugins.sh
fi

echo "---------------------------------------------------------"
echo "$(tput setaf 2)Linking dotfiles.$(tput sgr 0)"
echo "---------------------------------------------------------"

ln -s $HOME/dotfiles/nvim $HOME/.config/nvim
ln -s $HOME/dotfiles/tmux.conf $HOME/.tmux.conf
ln -s $HOME/dotfiles/rgrc $HOME/.rgrc
ln -s $HOME/dotfiles/git/gitconfig $HOME/.gitconfig
ln -s $HOME/dotfiles/git/gitignore $HOME/.gitignore

echo "---------------------------------------------------------"
echo "$(tput setaf 2)Installing vim plugins and CoC extensions.$(tput sgr 0)"
echo "---------------------------------------------------------"
nvim +PlugInstall +qall
nvim +UpdateRemotePlugins +qall

nvim +"CocInstall -sync coc-json coc-prettier coc-eslint coc-css coc-tsserver" +qall

echo "---------------------------------------------------------"
echo "$(tput setaf 2)Setting MacOS defaults.$(tput sgr 0)"
echo "---------------------------------------------------------"
source ./macos

echo "---------------------------------------------------------"
echo "$(tput setaf 2)Switching shell to zsh. You may need to logout.$(tput sgr 0)"
echo "---------------------------------------------------------"

sudo sh -c "echo $(which zsh) >> /etc/shells"
chsh -s $(which zsh)

exit 0
