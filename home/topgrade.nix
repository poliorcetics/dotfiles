# Topgrade configuration
#
# <https://github.com/topgrade-rs/topgrade>

{ config, ... }:

let

  helixRepo = "${config.xdg.cacheHome}/helix-repo";
  ra-target-dir = "${config.xdg.cacheHome}/target-dirs/cargo/rust-analyzer-topgrade";

in
{
  programs.topgrade.enable = true;

  # Settings: <https://github.com/topgrade-rs/topgrade/blob/main/config.example.toml>
  programs.topgrade.settings = {
    commands = {
      "1. Helix - Install from repo" = "cd ${helixRepo} && cargo +stable install --locked --path helix-term && hx --grammar fetch && hx --grammar build";
      # Locked install because of https://github.com/rust-lang/rust-analyzer/issues/17914 for now
      "2. Rust-Analyzer - Install from git" = "CARGO_TARGET_DIR=${ra-target-dir} cargo +stable install --locked --git https://github.com/rust-lang/rust-analyzer --branch master --force rust-analyzer";
    };

    firmware.upgrade = false;

    git.repos = [ helixRepo ];

    misc = {
      assume_yes = false;
      cleanup = true;
      display_time = true;
      no_retry = true;

      only = [
        "brew_cask"
        "brew_formula"

        "git_repos"

        "nix"
        "rustup"
        "cargo"

        "pip3"
        "tldr"

        "custom_commands"
      ];
    };
  };
}
