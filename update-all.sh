#!/usr/bin/bash
#
#  update_all.sh 
#     update all user profile/default editor settings on system
#     author: larkins 2025
#
HOMEDIR=/home
SKELDIR=/etc/skel
#UPDATEDSKEL=/opt/sa/skel/skel  # uncomment this if you want to use the NFS version
UPDATEDSKEL=.                   # keep this if you are running this from the git repo directory

SKIPFACSTAFF=0   # 1 = operate only on student accounts, 0 = all accounts

ARCHIVEEXPIRED=0 # set to 1 to move expired accounts into /home/archive
ARCHIVEDIR=/home/archive

# IMPORTANT
UPDATEFILES=0    # 0 = just print, 1 = copy files over

confirm() {
  read -p "${BOLD}Are you sure? [y|n]${NORMAL} " -n 1 -r
  echo  # move to newline
  if [[ $REPLY =~ ^[Yy]$ ]]; then
    return 1
  else
    return 0
  fi
}

BOLD=$(tput bold)
NORMAL=$(tput sgr0)
RED='\033[0;31m'
NC='\033[0m'

#
# loop over everything in /home
#
for homedir in $HOMEDIR/*
do
  echo -n "${BOLD}$homedir "
  user=`stat --format=%U $homedir`
  group=`stat --format=%G $homedir`
  facstaff=0


  # figure out what type of directory this is

  if [[ -L $homedir || ! -d $homedir ]]; then
    # skip files and symlinks
    echo "- not a directory${NORMAL}"
    continue

  elif [[ $homedir == $ARCHIVEDIR ]]; then
    # skip over the place we archive expired accounts
    echo " - archive directory${NORMAL}"
    continue

  elif [[ $user == "UNKNOWN" ]]; then
    # skip userids without usernames (expired accounts in LDAP/AD)
    echo "- expired account${NORMAL}"
    if [[ $ARCHIVEEXPIRED -eq 1 && -d $ARCHIVEDIR ]]; then
      username=`basename $homedir`
      /usr/bin/mv $homedir $ARCHIVEDIR/$username
    fi
    continue

  elif [[ $homedir =~ comp[0-9]{3} ]]; then
    # skip shared folders for class information
    echo "- class directory${NORMAL}"
    continue

  elif [[ $group = students ]];then
    # all student directories are in the students group
    echo "- student directory${NORMAL}"

  else
    echo "- faculty/staff directory${NORMAL}"

    # tread more carefully with fac/staff accounts
    if [[ $SKIPFACSTAFF -eq 1 ]]; then
      continue
    else
      echo -e "${RED}**** potentially updating environment files for $user (fac/staff) ****${NC}"
      confirm
      if [ $? -eq 0 ]; then
        continue
      fi
      facstaff=1
    fi
  fi

  #
  # shell files
  #
  for dotfile in .bashrc .zshrc .profile .bash_logout
  do
    unchanged=0

    if [[ -s $homedir/$dotfile ]]; then
      cursum=`sha256sum $homedir/$dotfile | cut -f1 -d" "`
      skelsum=`sha256sum $SKELDIR/$dotfile | cut -f1 -d" "`
      if [[ $cursum = $skelsum ]]; then
        unchanged=1
      fi

    else 
      # treat missing files as unchanged (so we'll copy the updated file)
      unchanged=1
    fi

    # only update files if the user hasn't made customizations
    if [[ -f $UPDATEDSKEL/$dotfile && $unchanged -eq 1 ]]; then
      if [[ $UPDATEFILES -eq 1 ]]; then
        /usr/bin/install --owner=$user --group=$group $UPDATEDSKEL/$dotfile $homedir/$dotfile
      else
        echo "  /usr/bin/install --owner=$user --group=$group $UPDATEDSKEL/$dotfile $homedir/$dotfile"
      fi
    fi

  done

  #
  # check neovim configuration
  #

  unchanged=0

  if [[ ! -d $homedir/.config/nvim ]]; then
    # treat missing files as unchanged (so we'll copy the updated file)
    unchanged=1
  else 
    nvimdiff=`diff -qr $SKELDIR/.config/nvim $homedir/.config/nvim | egrep -v lazy-lock.json`
    if [[ ${#nvimdiff} -eq 0 ]]; then
      unchanged=1
    fi
  fi

  if [[ $unchanged -eq 1 ]]; then
    if [[ $UPDATEFILES -eq 1 ]]; then
      /usr/bin/mkdir -p $homedir/.backup
      /usr/bin/chown $user:$group $homedir/.backup
      /usr/bin/mkdir -p $homedir/.config
      /usr/bin/cp -r $UPDATEDSKEL/.config/nvim $homedir/.config/.
      /usr/bin/chown $user:$group $homedir/.config
      /usr/bin/chown -R $user:$group $homedir/.config/nvim
      if [ -d $homedir/.local/state/nvim ]; then
        /usr/bin/mv $homedir/.local/state/nvim $homedir/.local/state/nvim.save
      fi
      if [ -d $homedir/.local/share/nvim ]; then
        /usr/bin/mv $homedir/.local/share/nvim $homedir/.local/share/nvim.save
      fi
    else
      echo "  /usr/bin/mkdir -p $homedir/.backup"
      echo "  /usr/bin/chown $user:$group $homedir/.backup"
      echo "  /usr/bin/mkdir -p $homedir/.config"
      echo "  /usr/bin/cp -r $UPDATEDSKEL/.config/nvim $homedir/.config/."
      echo "  /usr/bin/chown $user:$group $homedir/.config"
      echo "  /usr/bin/chown -R $user:$group $homedir/.config/nvim"
      if [ -d $homedir/.local/state/nvim ]; then
        echo "  /usr/bin/mv $homedir/.local/state/nvim $homedir/.local/state/nvim.save"
      fi
      if [ -d $homedir/.local/share/nvim ]; then
        echo "  /usr/bin/mv $homedir/.local/share/nvim $homedir/.local/share/nvim.save"
      fi
    fi
  fi
  echo ""

done
