let fish_completer = {|spans|
    fish --command $'complete "--do-complete=($spans | str join " ")"'
    | $"value(char tab)description(char newline)" + $in
    | from tsv --flexible --no-infer
}

let carapace_completer = {|spans: list<string>|
    carapace $spans.0 nushell ...$spans
    | from json
    | if ($in | default [] | where value =~ '(.*ERR|^_)$' | is-empty) { $in } else { null }
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
    match $spans.0 {
        nu => $fish_completer,
        git => $fish_completer,
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

$env.config.hooks.env_change.PWD = ($env.config.hooks.env_change | default [] PWD | get PWD)

# Change CARGO_TARGET_DIR when PWD changes
$env.config.hooks.env_change.PWD = ($env.config.hooks.env_change.PWD | append {|_prev, new|
    let current_target_dir = ($env | get --ignore-errors CARGO_TARGET_DIR | default "")

    if $current_target_dir == "" or $current_target_dir =~ $"($env.XDG_CACHE_HOME)/target-dirs/cargo/*" {
        let new_target_dir = $"($env.XDG_CACHE_HOME)/target-dirs/cargo/($new | path basename)"
        $env.CARGO_TARGET_DIR = $new_target_dir
    }
})

$env.config.hooks.env_change.PWD = ($env.config.hooks.env_change.PWD | append {|_prev, new|
    if (which direnv | is-empty) {
        return
    }

    direnv export json | from json | default {} | load-env
    # Fixes completions of binaries by reworking the path to always be a list of strings
    if ($env.PATH | describe) == "string" {
        $env.PATH = ($env.PATH | split row ':')
    }
})

def nuopen [arg, --raw (-r)] { if $raw { open -r $arg } else { open $arg } }
alias open = ^open

def --wrapped npm [...rest] {
    PREFIX=$env.XDG_CONFIG_HOME ^npm ...$rest
}

# List all and trim down to some select columns
def la [path: path = "."]: any -> table {
    ls --all --long $path | sort-by type name | select mode size user modified type name target
}

# `la` but clearing the screen before
def lm [path: path = "."]: any -> table {
    clear; la $path
}
