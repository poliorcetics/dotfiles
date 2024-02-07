# Topgrade configuration
#
# <https://github.com/topgrade-rs/topgrade>

{ config, ... }:

let

  helixRepo = "${config.xdg.cacheHome}/helix-repo";

in {
  programs.topgrade.enable = true;

  # Settings: <https://github.com/topgrade-rs/topgrade/blob/main/config.example.toml>
  programs.topgrade.settings = {
    commands = {
      "1. Rustup - No Self Update" = "rustup update --no-self-update";
      "2. Helix - Install from repo" = "cd ${helixRepo} && cargo +stable install --locked --path helix-term && hx --grammar fetch && hx --grammar build";
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
        "home_manager"
        "cargo"

        "pip3"
        "tldr"

        "custom_commands"
      ];
    };
  };
}
