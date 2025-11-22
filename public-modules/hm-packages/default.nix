unstablePkgs:
{
  config,
  lib,
  pkgs,
  ...
}:
let
  # Overrides a binary provided by Nix with one that ends up later in the $PATH order:
  #
  # ```nix
  # overrideNixProvideBinary "hx" (lib.getExe config.programs.helix.package) "${config.home.sessionVariables.CARGO_HOME}/bin/hx";
  # ```
  overrideNixProvidedBinary =
    name: nix_pkg: replacement_path:
    (lib.hiPrio (
      pkgs.writeShellScriptBin name ''
        if test -x "${replacement_path}"; then
          builtin exec "${replacement_path}" "$@"
        else
          builtin exec "${nix_pkg}" "$@"
        fi
      ''
    ));
in
{
  home.packages =
    (with pkgs; [
      # == Cargo ==
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

      # == Kubernetes ==
      kubectl

      # == Nix ==
      nix-output-monitor

      # == Node ==
      nodePackages.bash-language-server # LSP for bash
      nodePackages.prettier # Code formatter, notably for Web technologies

      # == Rust ==
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
      pastel # Colors, colors everywhere
      procs # `ps` reinvented
      ripgrep # `grep` but 1000x better
      rnr # Rename things in bulk
      sd # `sed` but understandable
      taplo # TOML LSP
      tealdeer # Quick explanations of commands
      tokei # Count lines of code
      tree-sitter # Make semantic things
      watchexec # Execute in loops based on FS changes

      # == Misc. ==
      bear # Compile commands for C & C++ projects
      carapace # Command completer
      cmake # Compiler orchestration
      fish # Used for the carapace completer in nushell
      marksman # LSP for Markdown
      nixfmt-rfc-style # Official formatter for nix
      ninja # Compile C & C++ things
      yaml-language-server # LSP for YAML
    ])
    ++ [
      # == Unstable packages ==
      unstablePkgs.nixd # LSP for nix, actively maintained contrary to `nil`

      # == Homemade packages ==
      (pkgs.writeScriptBin "rust-analyzer-wrapper" (builtins.readFile ./rust-analyzer-wrapper.nu))
      (overrideNixProvidedBinary "rust-analyzer" "${pkgs.rustup}/bin/rust-analyzer"
        "${config.home.sessionVariables.CARGO_HOME}/bin/rust-analyzer"
      )
    ];
}
