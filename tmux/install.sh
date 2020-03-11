#!/bin/sh
builtin echo "\033[7m- TMUX setup -\033[0m"

# https://stackoverflow.com/questions/3601515/how-to-check-if-a-variable-is-set-in-bash
if builtin test -z ${DIRCONFIG+x}; then
  DIRCONFIG=$HOME/.config
  builtin export DIRCONFIG
  builtin echo "\033[32mSET DIRCONFIG = $DIRCONFIG\033[0m"
else
  builtin echo "Found DIRCONFIG: $DIRCONFIG"
fi

tmuxconf=$HOME/.tmux.conf
if builtin test -e $tmuxconf -o -L $tmuxconf; then
  old_tmuxconf=$tmuxconf.$$.old
  mv $tmuxconf $old_tmuxconf
  builtin echo "\033[32mMOVED OLD $tmuxconf to $old_tmuxconf \033[0m"
fi

local_tmuxconf=$DIRCONFIG/tmux/tmux.conf
builtin echo "Linking $HOME/.tmux.conf from $local_tmuxconf"
ln -s $local_tmuxconf $tmuxconf

builtin unset tmuxconf
builtin unset old_tmuxconf
builtin unset local_tmuxconf
