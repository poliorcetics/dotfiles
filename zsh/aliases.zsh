# ALIASES
# =======

# Rust-dependent aliases
# ----------------------

alias grep='rg' # crate: ripgrep
alias rgi='rg --no-ignore' # Also the ripgrep crate, this is a helpful shortcut
alias cat='bat -p' # crate: bat
alias ls='exa' # crate: exa
alias find='fd' # crate: fd-find
alias fdi='fd -I' # Also the fd-find crate
alias ps='procs' # crate: procs
alias sed='sd' # crate: sd
alias du='dust' # crate: du-dust
alias htop='ytop' # crate: ytop
alias top='ytop' # crate: ytop
alias diff='delta' # crate: git-delta
alias hexdump='hx' # crate: hx
alias objdump='bingrep' # crate: bingrep

alias ls='exa -F --colour-scale --time-style long-iso --group-directories-first';
alias la='exa -haF --colour-scale --time-style long-iso --group-directories-first';
alias ll='exa -lhaF --colour-scale --time-style long-iso --group-directories-first';
alias l='exa -lhF --colour-scale --time-style long-iso --group-directories-first';

alias lg='exa -lhaF --colour-scale --time-style long-iso --git --group-directories-first';
alias llg='exa -lhF --colour-scale --time-style long-iso --git --group-directories-first';
alias lmg='lm --git'; # 'lm' comes from a personal Rust crate in ~/bin/perso_lm
                      # and already has the --group-directories-first option

alias shistory='history 1 | rg'

# Git
# -----

alias git='LANG=en_GB.UTF-8 git'
alias g='git'

# Apple
# -----

alias showsystemfiles='defaults write com.apple.finder AppleShowAllFiles YES; killall Finder'
alias hidesystemfiles='defaults write com.apple.finder AppleShowAllFiles NO; killall Finder'

# Homebrew
# --------

alias b='brew'
alias bu='brew upgrade && brew cleanup'
alias bnuke='brew cleanup --prune 0'

# Cargo
# -----

alias cg='cargo'

alias cgn='cargo new'
alias cgb='cargo build'
alias cgt='cargo test'
alias cgr='cargo run'
alias cgx='cargo check'
alias cgl='cargo clean'

alias cgbr='cargo build --release'
alias cgtr='cargo test --release'
alias cgrr='cargo run --release'
alias cgxr='cargo check --release'

# Other
# -----

alias vim='nvim'
alias nv='nvim'
alias ..='z ..'
