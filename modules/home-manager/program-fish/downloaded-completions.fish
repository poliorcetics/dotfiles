# Downloads all my fish completions in the expected place, erroring when a hash has changed
# (and so the underlying file has changed).

function download --argument-names source_url target_file expected_hash
    set --local temp_file (mktemp --dry-run)

    # Uses the system's curl to respect proxies and macOS certs automatically
    curl \
        --fail \
        --globoff \
        --location \
        --proto-default https \
        --remote-time \
        --retry 5 \
        --no-clobber \
        --silent \
        --output $temp_file \
        $source_url
    if test $status != 0
        printf "Failed to download `%s` from `%s`\n" $target_file $source_url
        return 1
    end

    # Now the file exists
    trap "rm $temp_file; or true" EXIT

    echo "$expected_hash $temp_file" | sha256sum --status --strict --check -
    if test $status != 0
        printf "New hash:\n  %s  %s\n  %s\n" $expected_hash $target_file (sha256sum $temp_file)
        return 1
    end

    cp $temp_file $target_file; or return 1
end

set --local out_dir $argv[1]

download \
    'https://raw.githubusercontent.com/helix-editor/helix/master/contrib/completion/hx.fish' \
    "$out_dir/hx.fish" \
    ffb227ba59f672156fe573f1d2518e361c8c2b98e76ce1f413a1c42721c86f74
or echo 'Failed to download hx.fish, retry outside the dotfile update env to check for errors'
