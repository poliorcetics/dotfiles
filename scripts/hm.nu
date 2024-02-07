#!/usr/bin/env nu

export module main {
    use std assert

    export def "helix install" [] {
        cd $env.XDG_CACHE_HOME

        git clone https://github.com/helix-editor/helix.git --single-branch --branch master helix-repo

        cd helix-repo

        cargo +stable install --locked --path helix-term
        ln -s $"(pwd | path join "runtime")" $"($env.XDG_CONFIG_HOME | path join "helix")"

        # Will work in `~/.config/helix/runtime`, see <https://github.com/helix-editor/helix/issues/9565>
        hx --grammar fetch
        hx --grammar build
    }

    # Do the cargo crates and rustup toolchain installs
    export def "rust installs" [] {
        # Rustup
        rustup toolchain install nightly

        # Regular cargo installs
        cargo +stable install apple-codesign cargo-instruments cargo-upgrades
        cargo +stable install scm-record -F scm-diff-editor

        # Git installs
        cargo +stable install --git https://github.com/rust-lang/rust-analyzer --branch master --force rust-analyzer

        # Custom installs
        helix install
    }

    export module brew {
        export def casks [] {
            brew install --cask appcleaner db-browser-for-sqlite firefox kitty monitorcontrol orbstack transmission tunnelblick vlc zulip
        }

        # Install brew on macOS
        export def init [] {
            let installer = http get https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh
            /usr/bin/env bash -c $"($installer)"

            casks
        }
    }
}

export use main

export def main [] {}
