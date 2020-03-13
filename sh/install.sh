#!/bin/sh
builtin echo "\033[7m- Shell setup -\033[0m"

# https://stackoverflow.com/questions/3601515/how-to-check-if-a-variable-is-set-in-bash
if builtin test -z ${DIRCONFIG+x}; then
  DIRCONFIG=$HOME/.config
  builtin export DIRCONFIG
  builtin echo "\033[32mSET DIRCONFIG = $DIRCONFIG\033[0m"
else
  builtin echo "Found DIRCONFIG: $DIRCONFIG"
fi

shell_file=""
if ! builtin test -z ${ZSH_NAME+x}; then
  shell_file=zshrc
elif ! builtin test -z ${BASH+x}; then
  shell_file=bashrc
fi

shell_rc=$HOME/.$shell_file
if builtin test -e $shell_rc -o -L $shell_rc; then
  old_shell_rc=$shell_rc.$$.old
  mv $shell_rc $old_shell_rc
  builtin echo "\033[32mMOVED OLD $shell_rc to $old_shell_rc \033[0m"
fi

local_shell_rc=$DIRCONFIG/sh/profile
builtin echo "Linking $shell_rc file from $local_shell_rc"
ln -s $local_shell_rc $shell_rc

( cd $DIRCONFIG/sh/bin && make $DIRCONFIG )
builtin unset shell_rc
builtin unset old_shell_rc
builtin unset shell_file
builtin unset local_shell_rc
