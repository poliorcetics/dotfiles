#!/usr/bin/env nu

# Hide/show hidden files in the Finder
#
# Does nothing when not on macOS
def main [
    --show # If `true`, show the hidden files in the Finder, else hide them
] {
    if $nu.os-info.name != "macos" { return }

    /usr/bin/defaults write com.apple.finder AppleShowAllFiles (if $show { "YES" } else { "NO" })
    /usr/bin/killall Finder
}
