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
$env.config.completions.external.enable = true
$env.config.completions.external.completer = {|spans: list<string>|
    # <https://www.nushell.sh/cookbook/external_completers.html#carapace-completer>
    def fish_completer [spans: list<string>] {
        fish --command $"complete '--do-complete=($spans | str replace --all "'" "\\'" | str join ' ')'"
        | from tsv --flexible --noheaders --no-infer
        | rename value description
        | update value {|row|
          let value = $row.value
          let need_quote = ['\' ',' '[' ']' '(' ')' ' ' '\t' "'" '"' "`"] | any {$in in $value}
          if ($need_quote and ($value | path exists)) {
            let expanded_path = if ($value starts-with ~) {$value | path expand --no-symlink} else {$value}
            $'"($expanded_path | str replace --all "\"" "\\\"")"'
          } else {
            $value
          }
        }
    }

    carapace $spans.0 nushell ...$spans
        | from json
        | if ($in | default [] | any {|| $in.display == 'ERR' or $in.display == '_' }) {
            $in
          } else {
            fish_completer $spans
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
