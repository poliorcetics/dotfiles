{
  config,
  lib,
  pkgs,
  unstablePkgs,
  ...
}:
let
  # Import my helper functions
  funcs = import ./home-manager/functions.nix { inherit lib pkgs; };
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

      # == Misc. ==
      bear # Compile commands for C & C++ projects
      carapace # Command completer
      cmake # Compiler orchestration
      fish # Used for the carapace completer in nushell
      marksman # LSP for Markdown
      nixfmt-rfc-style # Official formatter for nix
      ninja # Compile C & C++ things
      poetry # Project manager / venv manager for Python
      yaml-language-server # LSP for YAML
    ])
    ++ [
      # == Unstable packages ==
      unstablePkgs.nixd # LSP for nix, actively maintained contrary to `nil`

      # == Homemade packages ==
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
}
