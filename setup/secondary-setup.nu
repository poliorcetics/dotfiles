#!/usr/bin/env nu

# Install helix from HEAD
export def "main helix install" [] {
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
export def "main rust installs" [] {
    # Rustup
    rustup toolchain install stable
    rustup toolchain install nightly

    # Git installs
    cargo +stable install --git https://github.com/rust-lang/rust-analyzer --branch master --force rust-analyzer

    # Custom installs
    helix install

    # Regular cargo installs
    cargo +stable install cargo-instruments cargo-upgrades
}

export def "main iosevka build" [] {
    cd $env.XDG_CACHE_HOME

    git clone https://github.com/be5invis/Iosevka.git --single-branch --branch main --depth 1 iosevka

    cd iosevka
    let plans = "private-build-plans.toml"

    ln -s $"($env.XDG_CONFIG_HOME | path join home-manager extras $"iosevka-($plans)")" $"(pwd | path join $plans)"

    nix shell nixpkgs#nodejs_24 nixpkgs#ttfautohint-nox --command npm install   --verbose
    nix shell nixpkgs#nodejs_24 nixpkgs#ttfautohint-nox --command npm run build --verbose -- contents::IosevkaCustom
}

# Setup time machines exclusions
export def "main tm setup-exclusions" [] {
    /usr/bin/sudo /usr/bin/tmutil addexclusion -p $env.XDG_CACHE_HOME
    /usr/bin/sudo /usr/bin/tmutil addexclusion -p $env.XDG_STATE_HOME
    /usr/bin/sudo /usr/bin/tmutil addexclusion -p ($env.HOME | path join .cache)
    /usr/bin/sudo /usr/bin/tmutil addexclusion -p /nix/store
    /usr/bin/sudo /usr/bin/tmutil addexclusion -p /nix/var
}

export def main [] {}
