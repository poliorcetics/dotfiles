# Home Manager config
#
# Main documentation: <https://nix-community.github.io/home-manager/index.xhtml>
# All options: <https://nix-community.github.io/home-manager/options.xhtml>
{ config, lib, pkgs, userDetails, ... }:

let
  # Imports other Nix files from the repo to configure various elements
  imports = [
    ./atuin.nix
    ./bat.nix
    ./direnv.nix
    ./gh.nix
    ./git.nix
    ./helix
    ./jujutsu.nix
    ./kitty.nix
    ./shell.nix
    ./starship.nix
    ./topgrade.nix
  ];

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

  pythonPackages = with pkgs.python3Packages; [
    python
    pip
  ];

  rustPackages = with pkgs; [
    # Use rustup from nix but manage rust versions through rustup, not nix
    rustup

    atuin # Magical shell history
    bat # cat(1) on wings
    bottom # like `top`
    delta # Nicer git diffs
    difftastic # Semantic (tree-sitter) diffs
    du-dust # `du` reinvented
    eza # `ls` reinvented
    fd # `find` reinvented
    gitui # TUI for git, inspired by `tig`
    hyperfine # benchmarking made easy
    jujutsu # Nicer VCS than Git
    jless # `less` for JSON
    just # Just a command runner
    mdbook # Make HTML books out of markdown
    nushell # A shell for the modern world
    pastel # Colors, colors everywhere
    procs # `ps` reinvented
    ripgrep # `grep` but 1000x better
    rnr # Rename things in bulk
    sd # `sed` but understandable
    starship # A shell prompt for the stars
    tealdeer # Quick explanations of commands
    tokei # Count lines of code
    topgrade # Upgrade everything
    tree-sitter # Make semantic things
    watchexec # Execute in loops based on FS changes
    zoxide # `cd`, but with jumps and shortcuts
  ];

  miscPackages = with pkgs; [
    bear # Compile commands for C & C++ projects
    carapace # Command completer
    cmake # Compiler orchestration
    direnv # Setup env when entering/leaving directories
    fish # Used for the carapace completer in nushell
    gh # GitHub command line tools
    git # Git itself
    git-lfs # Support LFS in git
    marksman # LSP for Markdown
    nixd # LSP for nix, actively maintained contrary to `nil`
    ninja # Compile C & C++ things
    poetry # Project manager / venv manager for Python
    yaml-language-server # LSP for YAML
  ];

  # Import my helper functions
  funcs = import ./home-manager/functions.nix { inherit lib pkgs; };

  in

  {
    inherit imports;

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
      "${config.xdg.dataHome}/npm/bin"
      "/opt/homebrew/bin"
    ];

    # XDG setup
    xdg.enable = true;
    xdg.configHome = "${config.home.homeDirectory}/.config";
    # Put all dirs in .local because I like having $HOME as clean as possible
    xdg.cacheHome = "${config.home.homeDirectory}/.local/cache";
    xdg.dataHome = "${config.home.homeDirectory}/.local/share";
    xdg.stateHome = "${config.home.homeDirectory}/.local/state";

    # The home.packages option allows you to install Nix packages into your environment.
    home.packages =
      cargoPackages
      ++ nodePackages
      ++ pythonPackages
      ++ rustPackages
      ++ miscPackages
      ++ [
        # It is sometimes useful to fine-tune packages, for example, by applying overrides. You can do
        # that directly here, just don't forget the parentheses. Maybe you want to install Nerd Fonts
        # with a limited number of fonts?
        #: (pkgs.nerdfonts.override { fonts = [ "FantasqueSansMono" ]; })

        # You can also create simple shell scripts directly inside your configuration. For example,
        # this adds a command 'my-hello' to your environment:
        #: (pkgs.writeShellScriptBin "my-hello" ''
        #:   echo "Hello, ${config.home.username}!"
        #: '')

        (pkgs.writeScriptBin "hn" (builtins.readFile ./scripts/hn.nu))
        (pkgs.writeScriptBin "systemfiles" (builtins.readFile ./scripts/systemfiles.nu))

        # Voluntarily override the helix from the nixpkgs source to allow building the one from master
        # or any other dev branch easily
        (funcs.overrideNixProvidedBinary
          "hx"
          (lib.getExe config.programs.helix.package)
          "${config.home.sessionVariables.CARGO_HOME}/bin/hx")
        (funcs.overrideNixProvidedBinary
          "nu"
          (lib.getExe config.programs.nushell.package)
          "${config.home.sessionVariables.CARGO_HOME}/bin/nu")
        (funcs.overrideNixProvidedBinary
          "rust-analyzer"
          "${pkgs.rustup}/bin/rust-analyzer"
          "${config.home.sessionVariables.CARGO_HOME}/bin/rust-analyzer")
      ];

    # Home Manager is pretty good at managing dotfiles. The primary way to manage plain files is
    # through 'home.file'.
    home.file = {
      # Building this configuration will create a copy of 'dotfiles/screenrc' in the Nix store.
      # Activating the configuration will then make '~/.screenrc' a symlink to the Nix store copy.
      #: ".screenrc".source = dotfiles/screenrc;

      # You can also set the file content immediately.
      #:  ".gradle/gradle.properties".text = ''
      #:    org.gradle.console=verbose
      #:    org.gradle.daemon.idletimeout=3600000
      #:  '';
    };

    # Home Manager can also manage your environment variables through 'home.sessionVariables'. If
    # you don't want to manage your shell through Home Manager then you have to manually source
    # 'hm-session-vars.sh' located at either
    #
    #  ~/.nix-profile/etc/profile.d/hm-session-vars.sh
    #
    # or
    #
    #  ~/.local/state/nix/profiles/profile/etc/profile.d/hm-session-vars.sh
    #
    # or
    #
    #  /etc/profiles/per-user/alexis/etc/profile.d/hm-session-vars.sh
    #
    # Those variables are only defined once, opening a new shell does not redefine them I think
    home.sessionVariables = {
      EDITOR = "hx";
      VISUAL = "hx";

      LESS = "-R";
      LESSHISTFILE = "-";

      VIRTUAL_ENV_DISABLE_PROMPT = 1;

      # Where the tempdirs are created, if at all respected. The other XDG env vars are created
      # by the `xdg.enable = true` earlier
      XDG_RUNTIME_DIR = "/var/tmp/$(id -u)";

      JJ_CONFIG = "${config.xdg.configHome}/jj/config.toml";

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

      # NPM, incapable of answering to `XDG` spec and creating at least 3 dirs in ~/
      NPM_CONFIG_USERCONFIG = "${config.xdg.configHome}/npm/npmrc";

      PYTHONSTARTUP = "${config.xdg.configHome}/python/rc.py";

      # Rust
      RUSTUP_HOME = "${config.xdg.dataHome}/rustup";
      CARGO_HOME = "${config.xdg.dataHome}/cargo";

      STARSHIP_CACHE = "${config.xdg.cacheHome}/starship";

      SOLARGRAPH_CACHE = "${config.xdg.cacheHome}/solargraph"; # Ruby LSP

      TERMINFO = "${config.xdg.dataHome}/terminfo";
      TERMINFO_DIRS = "${config.xdg.dataHome}/terminfo:/usr/share/terminfo";

      WORKON_HOME = "${config.xdg.cacheHome}/virtualenvs";

      _ZO_DATA_DIR = "${config.xdg.stateHome}/zoxide";
    };

    # === PROGRAMS ===
    #
    # NOTE: be careful of nushell integration, if I decide to use `nushell.enable = true`, I may need shenanigans

    # Let Home Manager install and manage itself.
    programs.home-manager.enable = true;

    # Programs for which the config is not modified
    programs.bottom.enable = true;

    programs.carapace = {
      enable = true;
      # I do my own carapace integration in Nushell
      enableNushellIntegration = false;
    };

    programs.gitui.enable = true;

    programs.tealdeer.enable = true;

    # Avoid zoxide nushell integration as long as I'm not on a version with the changes from
    # <https://github.com/ajeetdsouza/zoxide/pull/663>
    programs.zoxide = {
      enable = true;
      enableNushellIntegration = false;
    };

    # === FILES ===

    # NPM has ways to configure it to not use ~/.npm but it's apparently buggy, let's hope this one works
    xdg.configFile."npm/npmrc".text = ''
      cache=~/.local/cache/npm
      prefix=~/.local/share/npm
    '';

    # Workaround to ensure the python history is not in ~/
    xdg.configFile."python/rc.py".source = ./python/rc.py;
  }
