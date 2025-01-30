use std assert

# Downloads all my nushell completions in the expected place,
# erroring when a hash has changed (and so the underlying file has changed)
def main [
    completion_dir: directory, # Where the files will be saved
] {
    # TODO: add more completions, either by contributing and linking them here or by manually maintaining them.
    (dl
        https://raw.githubusercontent.com/helix-editor/helix/master/contrib/completion/hx.nu
        ($completion_dir | path join hx.nu)
        '99b527d9deb591a1b4d3400cca70c407e4557ef3f077214e2ff34cef9dbddc2a')
}

def dl [
    url: string,
    file: path,
    expected_hash: string,
] {
    let file_content = http get $url
    let actual_hash = $file_content | hash sha256

    if $actual_hash != $expected_hash {
        error make {
            msg: $"found a different hash for '($url)'"
            label: {
                text: $"got '($actual_hash)' instead"
                span: (metadata $expected_hash).span
            }
            help: "change the hash to the new one"
        }
    }

    $file_content | save --force $file
}
