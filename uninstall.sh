#bin/bash

echo "restoring your default configuration files"

if [ -f $HOME/.bashrc.original ]; then
  /usr/bin/mv $HOME/.bashrc.original $HOME/.bashrc
fi

if [ -f $HOME/.profile.original ]; then
  /usr/bin/mv $HOME/.profile.original $HOME/.profile
fi

if [ -f $HOME/.zshrc.original ]; then
  /usr/bin/mv $HOME/.zshrc.original $HOME/.zshrc
fi

if [ -d $HOME/.config/nvim.original ]; then
  /usr/bin/rm -fr $HOME/.config/nvim
  /usr/bin/mv $HOME/.config/nvim.original $HOME/.config/nvim
fi
if [ -d $HOME/.local/share/nvim.original ]; then
  /usr/bin/rm -fr $HOME/.local/share/nvim
  /usr/bin/mv $HOME/.local/share/nvim.original $HOME/.local/share/nvim
fi
if [ -d $HOME/.local/state/nvim.original ]; then
  /usr/bin/rm -fr $HOME/.local/state/nvim
  /usr/bin/mv $HOME/.local/state/nvim.original $HOME/.local/state/nvim
fi

echo "restoration complete -- logout and login to see changes"
