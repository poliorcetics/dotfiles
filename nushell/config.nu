let fish_completer = {|spans|
    fish --command $'complete "--do-complete=($spans | str join " ")"'
    | $"value(char tab)description(char newline)" + $in
    | from tsv --flexible --no-infer
}

let carapace_completer = {|spans: list<string>|
    carapace $spans.0 nushell ...$spans
    | from json
    | if ($in | default [] | where value =~ '^-.*ERR$' | is-empty) { $in } else { null }
}

# This completer will use carapace by default
let external_completer = {|spans|
    let expanded_alias = scope aliases
    | where name == $spans.0
    | get -i 0.expansion

    let spans = if $expanded_alias != null {
        $spans
        | skip 1
        | prepend ($expanded_alias | split row ' ')
    } else {
        $spans
    }

    # carapace completions are incorrect for nu
    # fish completes commits and branch names in a nicer way
    # carapace doesn't have completions for asdf
    match $spans.0 {
        nu => $fish_completer,
        git => $fish_completer,
        asdf => $fish_completer,
        _ => $carapace_completer,
    } | do $in $spans
}

# External completions through `fish` and `carapace`
#
# See https://www.nushell.sh/cookbook/external_completers.html#putting-it-all-together
$env.config.completions.external = {
    enable: true
    completer: $external_completer
}

$env.config.show_banner = false
$env.config.history.file_format = "sqlite"
$env.config.history.isolation = true

# Change CARGO_TARGET_DIR when PWD changes
$env.config.hooks.env_change.PWD = ($env.config.hooks.env_change.PWD | append {|_prev, new|
    let new = ($new | path basename)
    let new_target_dir = $"($env.XDG_CACHE_HOME)/cargo_target_dir/($new)"
    let current_target_dir = ($env | get --ignore-errors CARGO_TARGET_DIR | default "")

    if $current_target_dir == "" or $current_target_dir =~ $"($env.XDG_CACHE_HOME)/cargo_target_dir/*" {
        $env.CARGO_TARGET_DIR = $new_target_dir
    }
})

def nuopen [arg, --raw (-r)] { if $raw { open -r $arg } else { open $arg } }
alias open = ^open

def --wrapped npm [...rest] {
    PREFIX=$env.XDG_CONFIG_HOME ^npm ...$rest
}

# List all and trim down to some select columns
def la [path: string = "."] -> record {
    ls --all --long $path | sort-by type | select mode size user modified type name target
}

# `la` but clearing the screen before
def lm [path: string = "."] -> record {
    clear; la $path
}
