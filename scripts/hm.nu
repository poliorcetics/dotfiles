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
        rustup toolchain install stable
        rustup toolchain install nightly

        # Regular cargo installs
        cargo +stable install apple-codesign cargo-instruments cargo-update cargo-upgrades
        cargo +stable install scm-record -F scm-diff-editor

        # Git installs
        cargo +stable install --git https://github.com/rust-lang/rust-analyzer --branch master --force rust-analyzer

        # Custom installs
        helix install
    }

    export module brew {
        export def casks [] {
            brew install --cask appcleaner db-browser-for-sqlite firefox kitty macs-fan-control monitorcontrol orbstack rectangle signal transmission tunnelblick vlc zulip

            # Link kitty terminfo to their new place
            let link_dir = $env.XDG_DATA_HOME | path join "terminfo/78"
            /bin/ln -s /Applications/kitty.app/Contents/Resources/terminfo/78/xterm-kitty ($link_dir | path join xterm-kitty)
        }

        # Install brew on macOS
        export def init [] {
            let installer = http get https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh
            /usr/bin/env bash -c $"($installer)"

            casks
        }
    }

    export def "iosevka build" [] {
        cd $env.XDG_CACHE_HOME

        git clone https://github.com/be5invis/Iosevka.git --single-branch --branch main --depth 1 iosevka

        cd iosevka
        let plans = "private-build-plans.toml"

        ln -s $"($env.XDG_CONFIG_HOME | path join home-manager iosevka $plans)" $"(pwd | path join $plans)"

        nix shell nixpkgs#nodejs_21 nixpkgs#ttfautohint-nox --command npm install   --verbose
        nix shell nixpkgs#nodejs_21 nixpkgs#ttfautohint-nox --command npm run build --verbose -- contents::IosevkaCustom
    }

    export module tm {
        # Setup time machines exclusions 
        export def setup-exclusions [] {
            sudo /usr/bin/tmutil addexclusion -p $env.XDG_CACHE_HOME
            sudo /usr/bin/tmutil addexclusion -p $env.XDG_STATE_HOME
            sudo /usr/bin/tmutil addexclusion -p /nix/store
            sudo /usr/bin/tmutil addexclusion -p /nix/var
        }
    }
}

export use main

export def main [] {}
