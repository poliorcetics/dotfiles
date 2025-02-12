{ config, pkgs, ... }:

{
  # Home Manager needs a bit of information about you and the paths it should manage.
  home.username = "alexis";
  home.homeDirectory = "/Users/alexis";

  # This value determines the Home Manager release that your configuration is compatible with. This
  # helps avoid breakage when a new Home Manager release introduces backwards incompatible changes.
  #
  # You should not change this value, even if you update Home Manager. If you do want to update the
  # value, then make sure to first check the Home Manager release notes.
  home.stateVersion = "23.11"; # Please read the comment before changing.

  # The home.packages option allows you to install Nix packages into your environment.
  home.packages = with pkgs; [
    bear
    carapace
    cmake
    direnv
    fish # Used for the carapac completer in nushell
    gh
    git
    git-lfs
    kitty
    ninja
    poetry
    python3
    yaml-language-server

    nodePackages.bash-language-server
    nodePackages.prettier

    # Rust packages
    #
    # Missing: git packages
    #  - helix
    #  - rust-analyzer
    # Missing: cargo-upgrades cargo-instruments apple-codesign (outdated as heck)
    alacritty
    atuin
    bacon
    bat
    bottom
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
    tree-sitter
    watchexec
    zellij
    zoxide

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
  home.sessionVariables = rec {
    EDITOR = "hx";
    VISUAL = "hx";

    LESS = "-R";
    LESSHISTFILE = "-";

    VIRTUAL_ENV_DISABLE_PROMPT = 1;

    # XDG setup
    XDG_CONFIG_HOME = "${config.home.homeDirectory}/.config";
    XDG_RUNTIME_DIR = "/var/tmp/$(id -u)";
    # Put all dirs in .local because I like having $HOME as clean as possible
    XDG_CACHE_HOME = "${config.home.homeDirectory}/.local/cache";
    XDG_DATA_HOME = "${config.home.homeDirectory}/.local/share";
    XDG_STATE_HOME = "${config.home.homeDirectory}/.local/state";

    JJ_CONFIG = "${XDG_CONFIG_HOME}/jj/config.toml";

    # Kubernetes, is a mess regarding what use which env var but let's try to make it work
    KUBECONFIG = "${XDG_CONFIG_HOME}/kube/config";
    KUBECACHEDIR = "${XDG_CACHE_HOME}/kube";

    # NPM, incapable of answering to `XDG` spec and creating at least 3 dirs in ~/
    NPM_CONFIG_USERCONFIG = "${XDG_CONFIG_HOME}/npm/npmrc";

    PYTHONSTARTUP = "${XDG_CONFIG_HOME}/python/rc.py";

    # Rust
    RUSTUP_HOME = "${XDG_CACHE_HOME}/rustup";
    CARGO_HOME = "${XDG_DATA_HOME}/cargo";

    STARSHIP_CACHE = "${XDG_CACHE_HOME}/starship";

    SOLARGRAPH_CACHE = "${XDG_CACHE_HOME}/solargraph"; # Ruby LSP

    TERMINFO = "${XDG_DATA_HOME}/terminfo";
    TERMINFO_DIRS = "${XDG_DATA_HOME}/terminfo:/usr/share/terminfo";

    WORKON_HOME = "${XDG_CACHE_HOME}/virtualenvs";

    ZELLIJ_CONFIG_DIR = "${XDG_CONFIG_HOME}/zellij";
    ZELLIJ_CONFIG_FILE = "${XDG_CONFIG_HOME}/zellij/config.kdl";

    _ZO_DATA_DIR = "${XDG_STATE_HOME}/zoxide";
  };

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;

  programs.bash = {
    enable = true;
    sessionVariables = config.home.sessionVariables;
    # The path manipulations are done here because otherwise the default .bashrc/.zshrc will prepend
    # the PATH in `home.sessionVariables` with the systems paths, which is not what I want at all
    initExtra = ''
      # TODO: Check this is used on Linux too ?
      if [ -e $HOME/.nix-profile/etc/profile.d/nix.sh ]; then
        source $HOME/.nix-profile/etc/profile.d/nix.sh
      fi

      if [ -e /nix/var/nix/profiles/default/etc/profile.d/nix-daemon.sh ]; then
          source /nix/var/nix/profiles/default/etc/profile.d/nix-daemon.sh
      fi

      mkdir -p "$XDG_RUNTIME_DIR"
      export PATH="$HOME/.local/bin/:$CARGO_HOME/bin:$XDG_DATA_HOME/npm/bin:$PATH";

      $HOME/.local/share/cargo/bin/nu
    '';
    historyFile = "${config.home.homeDirectory}/.config/bash/history";
  };
  programs.zsh = {
    enable = true;
    sessionVariables = config.home.sessionVariables;
    initExtra = config.programs.bash.initExtra;
    dotDir = ".config/zsh";
    history.path = "${config.home.homeDirectory}/.config/zsh/history";
  };
}
