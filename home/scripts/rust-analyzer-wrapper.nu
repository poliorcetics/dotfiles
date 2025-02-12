#!/usr/bin/env nu

def main [...args] {
    let target_dir = (
        cargo metadata --no-deps --format-version 1 --no-default-features --offline
        | from json
        | get workspace_root
        | path expand
        | $"($env.XDG_CACHE_HOME)/target-dirs/ra/($in | path basename)-($in | hash md5)"
    )

    CARGO_TARGET_DIR=$target_dir exec rust-analyzer ...$args
}
