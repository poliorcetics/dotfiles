echo "\033[7m- Vim setup -\033[0m"

# https://stackoverflow.com/questions/3601515/how-to-check-if-a-variable-is-set-in-bash
if test -z ${DIRCONFIG+x}; then
  DIRCONFIG=$HOME/.config
  export DIRCONFIG
  echo "\033[32mSET DIRCONFIG = $DIRCONFIG\033[0m"
else
  echo "Found DIRCONFIG: $DIRCONFIG"
fi

vimrc=$HOME/.vimrc
if test -e $vimrc -o -L $vimrc; then
  old_vimrc=$vimrc.$$.old
  mv $vimrc $old_vimrc
  echo "\033[32mMOVED OLD $vimrc to $old_vimrc \033[0m"
fi

local_vimrc=$DIRCONFIG/vim/vimrc
echo "Linking $HOME/.vimrc from $local_vimrc"
ln -s $local_vimrc $vimrc

unset vimrc
unset old_vimrc
unset local_vimrc
