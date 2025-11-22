# Home Manager config
#
# Main documentation: <https://nix-community.github.io/home-manager/index.xhtml>
# All options: <https://nix-community.github.io/home-manager/options.xhtml>
{
  # Imports other Nix files from the repo to configure various elements
  imports = [
    # Generic Home Manager options
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
}
