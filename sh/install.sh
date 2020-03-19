echo "\033[7m- Shell setup -\033[0m"

# https://stackoverflow.com/questions/3601515/how-to-check-if-a-variable-is-set-in-bash
if test -z ${DIRCONFIG+x}; then
  DIRCONFIG=$HOME/.config
  export DIRCONFIG
  echo "\033[32mSET DIRCONFIG = $DIRCONFIG\033[0m"
else
  echo "Found DIRCONFIG: $DIRCONFIG"
fi

shell_file="profile"
if ! test -z ${ZSH_NAME+x}; then
  shell_file=zshrc
elif ! test -z ${BASH+x}; then
  shell_file=bashrc
fi

shell_rc=$HOME/.$shell_file
if test -e $shell_rc -o -L $shell_rc; then
  old_shell_rc=$shell_rc.$$.old
  mv $shell_rc $old_shell_rc
  echo "\033[32mMOVED OLD $shell_rc to $old_shell_rc \033[0m"
fi

local_shell_rc=$DIRCONFIG/sh/profile
echo "Linking $shell_rc file from $local_shell_rc"
ln -s $local_shell_rc $shell_rc

( cd $DIRCONFIG/sh/bin && make $DIRCONFIG )
unset shell_rc
unset old_shell_rc
unset shell_file
unset local_shell_rc
