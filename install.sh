#bin/bash

echo "saving your default configuration files"


# shell things

if [ -f $HOME/.bashrc ]; then
  mv $HOME/.bashrc $HOME/.bashrc.original
fi

if [ -f $HOME/.bash_logout ]; then
  mv $HOME/.bash_logout $HOME/.bash_logout.original
fi

if [ -f $HOME/.profile ]; then
  mv $HOME/.profile $HOME/.profile.original
fi

if [ -f $HOME/.zshrc ]; then
  mv $HOME/.zshrc $HOME/.zshrc.original
fi

# neovim state
if [ -d $HOME/.config/nvim ]; then
  mv $HOME/.config/nvim $HOME/.config/nvim.original
fi
if [ -d $HOME/.local/share/nvim ]; then
  mv $HOME/.local/share/nvim $HOME/.local/share/nvim.original
fi
if [ -d $HOME/.local/state//nvim ]; then
  mv $HOME/.local/state/nvim $HOME/.local/state/nvim.original
fi

echo "installing default student environment in your home directory"

/usr/bin/install -m 600 .bashrc $HOME/.bashrc
/usr/bin/install -m 600 .profile $HOME/.profile
/usr/bin/install -m 600 .zshrc $HOME/.zshrc

/usr/bin/cp -r .config/nvim $HOME/.config

# set up nvim backup directory
if [ ! -e $HOME/.backup ]; then
  mkdir -p $HOME/.backup
fi

echo "installation complete -- logout and login to see changes"
