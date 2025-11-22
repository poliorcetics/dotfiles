# Used for actual configuration of Nushell,
# see `./autoload` for custom commands, env vars and such

# To see all documented configuration options:
#
#     config nu --doc | nu-highlight | bat -p
#
# To see all current values:
#
#     $env.config | table -e | bat -p

# External completions `carapace`
#
# <https://carapace-sh.github.io/carapace-bin/setup.html#nushell>
# <https://www.nushell.sh/cookbook/external_completers.html#putting-it-all-together>
$env.config.completions.external = {
    enable: true
    completer: {|spans: list<string>|
        carapace $spans.0 nushell ...$spans
            | from json
            | if ($in | default [] | where value =~ '(.*ERR|^_)$' | is-empty) { $in } else { null }
    }
}

$env.config.show_banner = false
$env.config.history.file_format = "sqlite"

$env.config.buffer_editor = "hx"

$env.config.hooks.env_change.PWD = ($env.config.hooks.env_change | default [] PWD | get PWD)

# Change CARGO_TARGET_DIR when PWD changes
$env.config.hooks.env_change.PWD = ($env.config.hooks.env_change.PWD | append {|_prev, new|
    let current_target_dir = ($env | get --optional CARGO_TARGET_DIR | default "")

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

$env.ENV_CONVERSIONS.__zoxide_hooked =  {
    from_string: {|s| $s | into bool }
    to_string: {|v| $v | into string }
}

$env.config.use_kitty_protocol = true
$env.config.shell_integration = {
    osc8: true
    osc9_9: true
}
