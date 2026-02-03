#!/usr/bin/env fish

function rust-analyzer-wrapper-main --wraps rust-analyzer
    set --local workspace_root (cargo metadata --no-deps --format-version 1 --no-default-features --offline | jq .workspace_root | path normalize)
    set --local target_dir $XDG_CACHE_HOME/target-dirs/ra/(path basename $workspace_root)-(md5 -s $workspace_root)

    CARGO_TARGET_DIR=$target_dir exec rust-analyzer $argv
end

rust-analyzer-wrapper-main $argv
