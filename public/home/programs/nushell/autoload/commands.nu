export alias cg = cargo
export alias g = git
export alias j = just

# Open a dated markdown note in ~/repos/notes/
export def hn [] {
    let now = (date now)
    let year = ($now | into record).year
    let note_dir = $"($env.HOME)/repos/notes/($year)"
    mkdir $note_dir
    cd $note_dir;
    hx --working-dir .. ($now | format date "%Y-%m-%d.md")
}

# List all and trim down to some select columns
export def la [path: glob = "."]: any -> table {
    ls --all --long $path | select mode size user modified type name target | sort-by type name
}

# `la` but clearing the screen before
export def lm [path: glob = "."]: any -> table {
    clear; la $path
}

export def --wrapped npm [...rest] {
    PREFIX=$env.XDG_CONFIG_HOME ^npm ...$rest
}

export def nuopen [arg, --raw (-r)] { if $raw { open -r $arg } else { open $arg } }
export alias open = ^open
