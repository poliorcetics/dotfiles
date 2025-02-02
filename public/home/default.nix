# Home Manager config
#
# Main documentation: <https://nix-community.github.io/home-manager/index.xhtml>
# All options: <https://nix-community.github.io/home-manager/options.xhtml>
{
  config,
  lib,
  pkgs,
  userDetails,
  unstablePkgs,
  ...
}:
let
  cargoPackages = with pkgs; [
    cargo-binutils
    cargo-deny
    cargo-dist
    cargo-expand
    cargo-llvm-lines
    cargo-modules
    cargo-nextest
    cargo-outdated
    cargo-release
    cargo-show-asm
    cargo-update
  ];

  nodePackages = with pkgs.nodePackages; [
    bash-language-server # LSP for bash
    prettier # Code formatter, notably for Web technologies
  ];

  rustPackages = with pkgs; [
    # Use rustup from nix but manage rust versions through rustup, not nix
    rustup

    bottom # like `top`
    delta # Nicer git diffs
    difftastic # Semantic (tree-sitter) diffs
    du-dust # `du` reinvented
    eza # `ls` reinvented
    fd # `find` reinvented
    gitui # TUI for git, inspired by `tig`
    hyperfine # benchmarking made easy
    jless # `less` for JSON
    just # Just a command runner
    mdbook # Make HTML books out of markdown
    nushell # A shell for the modern world
    pastel # Colors, colors everywhere
    procs # `ps` reinvented
    ripgrep # `grep` but 1000x better
    rnr # Rename things in bulk
    sd # `sed` but understandable
    tealdeer # Quick explanations of commands
    tokei # Count lines of code
    tree-sitter # Make semantic things
    watchexec # Execute in loops based on FS changes
  ];

  miscPackages =
    with pkgs;
    [
      bear # Compile commands for C & C++ projects
      carapace # Command completer
      cmake # Compiler orchestration
      fish # Used for the carapace completer in nushell
      marksman # LSP for Markdown
      nixfmt-rfc-style # Official formatter for nix
      ninja # Compile C & C++ things
      poetry # Project manager / venv manager for Python
      yaml-language-server # LSP for YAML
    ]
    ++ [
      unstablePkgs.nixd # LSP for nix, actively maintained contrary to `nil`
    ];

  # Import my helper functions
  funcs = import ./home-manager/functions.nix { inherit lib pkgs; };
in
{
  # Imports other Nix files from the repo to configure various elements
  imports = [
    ./programs/atuin
    ./programs/bat
    ./programs/direnv
    ./programs/gh
    ./git.nix
    ./helix
    ./jujutsu.nix
    ./kitty.nix
    ./npm.nix
    ./python
    ./shell.nix
    ./starship.nix
    ./topgrade.nix
    ./xdg.nix
    ./zoxide.nix
  ];

  # This value determines the Home Manager release that your configuration is compatible with. This
  # helps avoid breakage when a new Home Manager release introduces backwards incompatible changes.
  #
  # You should not change this value, even if you update Home Manager. If you do want to update the
  # value, then make sure to first check the Home Manager release notes.
  home.stateVersion = "24.05"; # Please read the comment before changing.

  # Home Manager needs a bit of information about you and the paths it should manage.
  home.username = userDetails.username;
  home.homeDirectory = userDetails.home;

  # Scripts to run on `home-manager switch`
  home.activation = import ./home-manager/activation.nix { inherit config lib; };
  home.sessionPath = [
    "${userDetails.home}/.local/bin"
    "${config.home.sessionVariables.CARGO_HOME}/bin"
    "/opt/homebrew/bin"
  ];

  home.packages =
    cargoPackages
    ++ nodePackages
    ++ rustPackages
    ++ miscPackages
    ++ [
      (pkgs.writeScriptBin "hn" (builtins.readFile ./scripts/hn.nu))
      (pkgs.writeScriptBin "rust-analyzer-wrapper" (builtins.readFile ./scripts/rust-analyzer-wrapper.nu))
      (pkgs.writeScriptBin "systemfiles" (builtins.readFile ./scripts/systemfiles.nu))

      # Voluntarily override the helix from the nixpkgs source to allow building the one from master
      # or any other dev branch easily
      (funcs.overrideNixProvidedBinary "hx" (lib.getExe config.programs.helix.package)
        "${config.home.sessionVariables.CARGO_HOME}/bin/hx"
      )
      (funcs.overrideNixProvidedBinary "nu" (lib.getExe config.programs.nushell.package)
        "${config.home.sessionVariables.CARGO_HOME}/bin/nu"
      )
      (funcs.overrideNixProvidedBinary "rust-analyzer" "${pkgs.rustup}/bin/rust-analyzer"
        "${config.home.sessionVariables.CARGO_HOME}/bin/rust-analyzer"
      )
    ];

  home.sessionVariables = {
    EDITOR = "hx";
    VISUAL = "hx";

    LESS = "-R";
    LESSHISTFILE = "-";

    # Kubernetes, is a mess regarding what use which env var but let's try to make it work
    KUBECONFIG = "${config.xdg.configHome}/kube/config";
    KUBECACHEDIR = "${config.xdg.cacheHome}/kube";

    LESS_TERMCAP_mb = "$(${lib.getExe config.programs.nushell.package} --commands 'ansi green')";
    LESS_TERMCAP_md = "$(${lib.getExe config.programs.nushell.package} --commands 'ansi light_cyan_bold')"; # start bold
    LESS_TERMCAP_me = "$(${lib.getExe config.programs.nushell.package} --commands 'ansi reset')"; # end bold
    LESS_TERMCAP_se = "$(${lib.getExe config.programs.nushell.package} --commands 'ansi reset')"; # end standout
    LESS_TERMCAP_so = "$(${lib.getExe config.programs.nushell.package} --commands 'ansi light_yellow_reverse')"; # start standout
    LESS_TERMCAP_ue = "$(${lib.getExe config.programs.nushell.package} --commands 'ansi reset')"; # end underline
    LESS_TERMCAP_us = "$(${lib.getExe config.programs.nushell.package} --commands 'ansi green_underline')"; # start underline

    # Rust
    RUSTUP_HOME = "${config.xdg.dataHome}/rustup";
    CARGO_HOME = "${config.xdg.dataHome}/cargo";

    TERMINFO = "${config.xdg.dataHome}/terminfo";
    TERMINFO_DIRS = "${config.xdg.dataHome}/terminfo:/usr/share/terminfo";
  };

  # === PROGRAMS ===
  #
  # NOTE: be careful of nushell integration, if I decide to use `nushell.enable = true`, I may need shenanigans

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
}
