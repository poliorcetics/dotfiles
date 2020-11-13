# ZSH Options
# ===========

# History options

setopt extended_history         # Record timestamp of command in HISTFILE
setopt hist_find_no_dups        # Ignore duplicates when searching history
setopt hist_ignore_all_dups     # Don't save duplicates
setopt hist_ignore_space        # Ignore commands that start with space
setopt hist_verify              # Show command with history expansion to user before running it
setopt inc_append_history       # Write to HISTFILE as soon as the command are entered
setopt share_history            # Share command history data

# Globbing options

setopt no_case_glob             # Ignore case when globbing
setopt no_case_match            # Ignore case when matching

# Environment variables
# =====================

export ZSH_CACHE_DIR=$HOME/.local/share/zsh
test -d $ZSH_CACHE_DIR || mkdir -p $ZSH_CACHE_DIR

export HISTORY_IGNORE=fg
export SAVEHIST=100000
export HISTSIZE=$SAVEHIST
export HISTFILE=$ZSH_CACHE_DIR/.zsh_history
export HISTTIMEFORMAT="[%F %T] "

export DIRCONFIG=$HOME/.config
export ZSH=$DIRCONFIG/zsh

case :$PATH: in
    *:/usr/local/bin:*)
        ;;
    *)
        export PATH=/usr/local/bin:$PATH
        ;;
esac

# Now nvim is in $PATH

export EDITOR=nvim

# Rust environment

export RUSTUP_HOME=$DIRCONFIG/rust/rustup
export CARGO_HOME=$DIRCONFIG/rust/cargo

case :$PATH: in
    *:$CARGO_HOME/bin:*)
        ;;
    *)
        export PATH=$CARGO_HOME/bin:$PATH
        ;;
esac

case :$PATH: in
    *:$HOME/bin:*)
        ;;
    *)
        export PATH=$HOME/bin:$PATH
        ;;
esac

# LANG
# ====

export LANG=en_GB.UTF-8

export LC_NUMERIC="fr_FR.UTF-8"
export LC_TIME="fr_FR.UTF-8"
export LC_COLLATE="fr_FR.UTF-8"
export LC_MONETARY="fr_FR.UTF-8"
export LC_MESSAGES="en_GB.UTF-8"
export LC_ALL="en_GB.UTF-8"

# ALIASES
# =======

source $ZSH/aliases.zsh

# Zoxide
# ------

# Needs to be after `$CARGO_HOME/bin` is in $PATH
eval "$(zoxide init zsh)"

# ZSH
# ===

bindkey ^A beginning-of-line
bindkey ^E end-of-line

# Highlighter
# -----------
# Update with brew
[ -f /usr/local/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh ] && source /usr/local/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh || true

# Completion
# ----------

# Upper/Lower key search history
autoload -U history-search-end
zle -N history-beginning-search-backward-end history-search-end
zle -N history-beginning-search-forward-end history-search-end
bindkey "^[[A" history-beginning-search-backward-end
bindkey "^[[B" history-beginning-search-forward-end

export fpath=( $DIRCONFIG/zsh $fpath )
autoload -Uz compinit
compinit

# Completion for kitty
kitty + complete setup zsh | source /dev/stdin

# Updates
# -------

source $ZSH/update_functions.zsh

# SKIM
# ====

SKIM_DEFAULT_COMMAND="git ls-files -co --exclude-standard || fd --type f"

# STARSHIP
# ==

# https://github.com/starship/starship
# See also: ../starship.toml for the configuration.
eval "$(starship init zsh)"
