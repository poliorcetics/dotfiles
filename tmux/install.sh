#!/bin/sh
echo "\033[7m- TMUX setup -\033[0m"

# https://stackoverflow.com/questions/3601515/how-to-check-if-a-variable-is-set-in-bash
if [ -z ${DIRCONFIG+x} ]; then
  DIRCONFIG=$HOME/.config
  export DIRCONFIG
  echo "\033[32mSET DIRCONFIG = $DIRCONFIG\033[0m"
else
  echo "Found DIRCONFIG: $DIRCONFIG"
fi

tmuxconf=$HOME/.tmux.conf
if [ -e $tmuxconf -o -L $tmuxconf ]; then
  old_tmuxconf=$tmuxconf.$$.old
  mv $tmuxconf $old_tmuxconf
  echo "\033[32mMOVED OLD $tmuxconf to $old_tmuxconf \033[0m"
fi

local_tmuxconf=$DIRCONFIG/tmux/tmux.conf
echo "Linking $HOME/.tmux.conf from $local_tmuxconf"
ln -s $local_tmuxconf $tmuxconf
