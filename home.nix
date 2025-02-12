# Home Manager config
#
# Main documentation: <https://nix-community.github.io/home-manager/index.xhtml>
# All options: <https://nix-community.github.io/home-manager/options.xhtml>
{ config, pkgs, ... }:

let
  # Imports other Nix files from the repo to configure various elements
  imports = [
    ./atuin.nix
    ./bacon.nix
    ./bat.nix
    ./gh.nix
    ./git.nix
    ./shell.nix
  ];

  # TODO: missing: cargo-upgrades cargo-instruments
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
    cargo-watch
  ];

  nodePackages = with pkgs.nodePackages; [
    bash-language-server # LSP for bash
    prettier # Code formatter, notably for Web technologies
  ];

  pythonPackages = with pkgs.python3Packages; [
    python
    pip
  ];

  # TODO: missing: apple-codesign (outdated as heck)
  # TODO: missing: git packages
  #  - helix
  #  - rust-analyzer
  rustPackages = with pkgs; [
    # Use rustup from nix but manage rust versions through rustup, not nix
    rustup

    atuin
    bacon
    bat
    bottom
    delta
    difftastic
    du-dust
    eza
    fd
    gitui
    hyperfine
    jujutsu
    jless
    just
    mdbook
    nushell
    pastel
    procs
    ripgrep
    rnr
    sd
    starship
    tealdeer
    tokei
    topgrade
    tree-sitter
    watchexec
    zellij
    zoxide
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
    ninja # 
    poetry
    yaml-language-server
  ];

  in

  {
    inherit imports;

    # Home Manager needs a bit of information about you and the paths it should manage.
    home.username = "alexis";
    home.homeDirectory = "/Users/alexis";

    # XDG setup
    xdg.enable = true;
    xdg.configHome = "${config.home.homeDirectory}/.config";
    # Put all dirs in .local because I like having $HOME as clean as possible
    xdg.cacheHome = "${config.home.homeDirectory}/.local/cache";
    xdg.dataHome = "${config.home.homeDirectory}/.local/share";
    xdg.stateHome = "${config.home.homeDirectory}/.local/state";

    # This value determines the Home Manager release that your configuration is compatible with. This
    # helps avoid breakage when a new Home Manager release introduces backwards incompatible changes.
    #
    # You should not change this value, even if you update Home Manager. If you do want to update the
    # value, then make sure to first check the Home Manager release notes.
    home.stateVersion = "24.05"; # Please read the comment before changing.

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

      # <https://docs.helix-editor.com/install.html#configuring-helixs-runtime-files>
      HELIX_RUNTIME = "${config.home.homeDirectory}/repos/tp/helix/runtime";

      JJ_CONFIG = "${config.xdg.configHome}/jj/config.toml";

      # Kubernetes, is a mess regarding what use which env var but let's try to make it work
      KUBECONFIG = "${config.xdg.configHome}/kube/config";
      KUBECACHEDIR = "${config.xdg.cacheHome}/kube";

      # NPM, incapable of answering to `XDG` spec and creating at least 3 dirs in ~/
      NPM_CONFIG_USERCONFIG = "${config.xdg.configHome}/npm/npmrc";

      PYTHONSTARTUP = "${config.xdg.configHome}/python/rc.py";

      # Rust
      RUSTUP_HOME = "${config.xdg.cacheHome}/rustup";
      CARGO_HOME = "${config.xdg.dataHome}/cargo";

      STARSHIP_CACHE = "${config.xdg.cacheHome}/starship";

      SOLARGRAPH_CACHE = "${config.xdg.cacheHome}/solargraph"; # Ruby LSP

      TERMINFO = "${config.xdg.dataHome}/terminfo";
      TERMINFO_DIRS = "${config.xdg.dataHome}/terminfo:/usr/share/terminfo";

      WORKON_HOME = "${config.xdg.cacheHome}/virtualenvs";

      ZELLIJ_CONFIG_DIR = "${config.xdg.configHome}/zellij";
      ZELLIJ_CONFIG_FILE = "${config.xdg.configHome}/zellij/config.kdl";

      _ZO_DATA_DIR = "${config.xdg.stateHome}/zoxide";
    };

    # === PROGRAMS ===

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

    # TODO: directories for which to import the files directly since home-manager doesn't handle them well
    # - .config/fish
    # - .config/helix
    # - .config/npm
    # - .config/nushell
    # - .config/pijul

    # TODO: programs to port the config for
    # NOTE: be careful of nushell integration, if I decide to use `nushell.enable = true`, I may need shenanigans
    # - kitty
    # - topgrade
    # - zellij
    # - starship

    # === FILES ===

    # Using file to get access to custom path: <https://github.com/nix-community/home-manager/issues/5001>
    xdg.configFile."jj/config.toml".source = ./jj/config.toml;

    # Usually tracking nix config is done via the user config in nixOS, or nix-darwin on macOS but I
    # don't want to have to install it too. This works for now.
    xdg.configFile."nix/nix.conf".source = ./nix/nix.conf;

    # Workaround to ensure the python history is not in ~/
    xdg.configFile."python/rc.py".source = ./python/rc.py;
  }
