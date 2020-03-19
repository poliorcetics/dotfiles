# Language for the shell config
LANG="fr_FR.UTF-8"
LC_NUMERIC=$LANG
LC_TIME=$LANG
LC_COLLATE=$LANG
LC_MONETARY=$LANG
LC_MESSAGES=$LANG
LC_ALL=$LANG
# Exports are separated to ensure bash-compatibility
export LANG
export LC_NUMERIC
export LC_TIME
export LC_COLLATE
export LC_MONETARY
export LC_MESSAGES
export LC_ALL

# Some basic aliases
alias c='clear'
alias grep='grep --colour=always'
alias git='LANG=en_GB.UTF-8 git'
alias rd='rmdir'
alias shistory='history | grep --colour=always'

# OS Specific aliases
if test `uname -s` = "Darwin"; then
  alias fd='open .'

  alias ls='ls -FG';
  alias la='ls -haFG';
  alias l='ls -lhaFG';
  alias ll='ls -lhFG';

  # show/hide system files
  alias showsystemfiles='defaults write com.apple.finder AppleShowAllFiles YES; killall Finder'
  alias hidesystemfiles='defaults write com.apple.finder AppleShowAllFiles NO; killall Finder'

  alias xcode='open -a Xcode'

  if test `command -v brew`; then
    alias bu='brew upgrade && brew cleanup'
    alias bl='brew list -1'
  fi

elif test "$OSTYPE" = "linux-gnu"; then

  alias ls='ls -F --color=auto';
  alias la='ls -haF --color=auto';
  alias l='ls -lhaF --color=auto';
  alias ll='ls -lhF --color=auto';

fi
