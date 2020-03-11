# Language for the shell config
LANG="fr_FR.UTF-8"
LC_NUMERIC=$LANG
LC_TIME=$LANG
LC_COLLATE=$LANG
LC_MONETARY=$LANG
LC_MESSAGES=$LANG
LC_ALL=$LANG
# Exports are separated to ensure bash-compatibility
builtin export LANG
builtin export LC_NUMERIC
builtin export LC_TIME
builtin export LC_COLLATE
builtin export LC_MONETARY
builtin export LC_MESSAGES
builtin export LC_ALL

# Some basic aliases
builtin alias c='clear'
builtin alias grep='grep --colour=always'
builtin alias git='LANG=en_GB.UTF-8 git'
builtin alias rd='rmdir'
builtin alias shistory='history | grep --colour=always'

# OS Specific aliases
if builtin test `uname -s` = "Darwin"; then
  builtin alias fd='open .'

  builtin alias ls='ls -FG';
  builtin alias la='ls -haFG';
  builtin alias l='ls -lhaFG';
  builtin alias ll='ls -lhFG';

  # show/hide system files
  builtin alias showsystemfiles='defaults write com.apple.finder AppleShowAllFiles YES; killall Finder'
  builtin alias hidesystemfiles='defaults write com.apple.finder AppleShowAllFiles NO; killall Finder'

  builtin alias xcode='open -a Xcode'

  if test `builtin command -v brew`; then
    builtin alias bu='brew upgrade && brew cleanup'
    builtin alias bl='brew list -1'
  fi

elif builtin test "$OSTYPE" = "linux-gnu"; then

  builtin alias ls='ls -F --color=auto';
  builtin alias la='ls -haF --color=auto';
  builtin alias l='ls -lhaF --color=auto';
  builtin alias ll='ls -lhF --color=auto';
# builtin alias lm='clear; ls -lhaF --color=auto';

fi
