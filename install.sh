#!/bin/sh
echo "\033[7m== Config setup ==\033[0m"

# https://stackoverflow.com/questions/3601515/how-to-check-if-a-variable-is-set-in-bash
if test -z ${DIRCONFIG+x}; then
  DIRCONFIG=$HOME/.config
  export DIRCONFIG
  echo "\033[32mSET DIRCONFIG = $DIRCONFIG\033[0m"
else
  echo "Found DIRCONFIG: $DIRCONFIG"
fi

./sh/install.sh
./vim/install.sh
./tmux/install.sh
