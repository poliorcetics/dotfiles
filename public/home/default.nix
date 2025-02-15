# Home Manager config
#
# Main documentation: <https://nix-community.github.io/home-manager/index.xhtml>
# All options: <https://nix-community.github.io/home-manager/options.xhtml>
{
  userDetails,
  ...
}:
{
  # Imports other Nix files from the repo to configure various elements
  imports = [
    # Generic Home Manager options
    ./home-manager/activation.nix
    ./home-manager/packages.nix
    ./home-manager/variables.nix
    ./home-manager/xdg.nix
    # Specific program configuration
    ./programs/atuin
    ./programs/bat
    ./programs/direnv
    ./programs/gh
    ./programs/git
    ./programs/helix
    ./programs/jj
    ./programs/kitty
    ./programs/npm
    ./programs/nushell
    ./programs/python
    ./programs/shell
    ./programs/starship
    ./programs/topgrade
    ./programs/zoxide
  ];

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;

  home = {
    # Home Manager needs a bit of information about you and the paths it should manage.
    inherit (userDetails) username;
    homeDirectory = userDetails.home;

    # This value determines the Home Manager release that your configuration is compatible with. This
    # helps avoid breakage when a new Home Manager release introduces backwards incompatible changes.
    #
    # You should not change this value, even if you update Home Manager. If you do want to update the
    # value, then make sure to first check the Home Manager release notes.
    stateVersion = "24.05"; # Please read the comment before changing.
  };
}
