# Bash completions

The content of this directory are parsed for regular files matching `[^.]*.bash-completions`.
They will be sourced inside the `bashrc` file.

## Known commands

This a list of the completion commands I know about.

- `swift package completion-tool generate-bash-script`
- `rustup completions bash`
- `rustup completions bash cargo`

The commands output their script on the standard output, be sure to redirect the result in the correct file (like `> $DIRCONFIG/sh/bash/completions/<file>.bash-completions`).
