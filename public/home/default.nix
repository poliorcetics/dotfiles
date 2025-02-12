# Home Manager config
#
# Main documentation: <https://nix-community.github.io/home-manager/index.xhtml>
# All options: <https://nix-community.github.io/home-manager/options.xhtml>
{
  config,
  lib,
  userDetails,
  ...
}:
{
  # Imports other Nix files from the repo to configure various elements
  imports = [
    ./programs/atuin
    ./programs/bat
    ./programs/direnv
    ./programs/gh
    ./programs/git
    ./programs/jj
    ./programs/kitty
    ./programs/npm
    ./programs/python
    ./programs/starship
    ./programs/topgrade
    ./programs/zoxide

    ./helix
    ./packages.nix
    ./shell.nix
    ./xdg.nix
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
    "${config.home.homeDirectory}/.local/bin"
    "${config.home.sessionVariables.CARGO_HOME}/bin"
    "/opt/homebrew/bin"
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
