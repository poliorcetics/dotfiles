# Fish shell
#
# <https://fishshell.com/docs/>

# Gather all target dirs in an unsaved directory by default (manual overrides are still respected).
function __my_env_change_pwd --on-variable PWD
    if not set --query CARGO_TARGET_DIR;
        or test $CARGO_TARGET_DIR = "";
        or string match --quiet --entire --ignore-case "$XDG_CACHE_HOME/target-dirs/cargo/*" $CARGO_TARGET_DIR

        set --global --export CARGO_TARGET_DIR "$XDG_CACHE_HOME/target-dirs/cargo/$(basename $PWD)"
    end
end

alias cg cargo
alias g git
alias j just
alias k kubectl

function hn --description "Open a dated markdown note in ~/repos/notes/"
    set --local year (date +%Y)
    set --local note_dir "$HOME/repos/notes/$year"
    mkdir -p $note_dir
    cd $note_dir
    hx --working-dir .. (date +%Y-%m-%d.md); or cd -; and cd -
end

alias ls eza

function la --wraps eza --description "List all, trimmed down to some select columns"
    # Sort by name, with uppercase _before_ lowercase because we use `Name` and not `name`
    eza \
        --all \
        --dereference \
        --group-directories-first \
        --hyperlink \
        --long \
        --sort Name \
        --sort type \
        --time-style relative \
        $argv
end

function lm --wraps eza --description "Wraps `la`, clearing the screen first"
    clear -x
    la $argv
end

function npm --wraps npm --description "Wraps npm to make it behave non stupidly"
    set --local --export PREFIX $XDG_CONFIG_HOME
    command npm $argv
end

function nix-config-gc --description "Garbage collect old nix and home manager profiles"
    argparse "hm=" "nix=" -- $argv

    set --query _flag_hm[1]; or set --local _flag_hm -1min
    set --query _flag_nix[1]; or set --local _flag_nix old

    nix run stable#home-manager -- expire-generations $_flag_hm
    nix-env --delete-generations $_flag_nix
    nix-collect-garbage
end
complete --command nix-config-gc --long-option hm --require-parameter --description "Argument to `home-manager expire-generations <arg>`"
complete --command nix-config-gc --long-option nix --require-parameter --description "Argument to `nix-env --delete-generations <arg>`"

source $XDG_CONFIG_HOME/fish/completions/hx.fish
source $XDG_CONFIG_HOME/fish/completions/atuin.fish
source $XDG_CONFIG_HOME/fish/completions/starship.fish

source $XDG_CONFIG_HOME/fish/inits/atuin.fish
source $XDG_CONFIG_HOME/fish/inits/starship.fish
source $XDG_CONFIG_HOME/fish/inits/zoxide.fish

bind alt-backspace 'commandline -f backward-kill-word'
bind alt-delete 'commandline -f backward-kill-word'

bind alt-left 'commandline -f backward-word'
bind alt-right 'commandline -f forward-word'
