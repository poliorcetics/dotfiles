# Environnement variables
# =======================

export DIRCONFIG=$HOME/.config
export ZSH=$DIRCONFIG/zsh

case :$HOME/bin: in
    :$PATH:)
        ;;
    *)
        export PATH=$HOME/bin:$PATH
        ;;
esac

export HISTORY_IGNORE=fg

export RUSTUP_HOME=$DIRCONFIG/rust/rustup
export CARGO_HOME=$DIRCONFIG/rust/cargo

case :$CARGO_HOME/bin: in
    :$PATH:)
        ;;
    *)
        export PATH=$PATH:$CARGO_HOME/bin
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

# STARSHIP
# ==

# https://github.com/starship/starship
# See also: ../starship.toml for the configuration.
eval "$(starship init zsh)"
