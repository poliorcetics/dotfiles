# Direnv configuration
#
# <https://direnv.net>

{ ... }:
{
  programs.direnv.enable = true;
  programs.direnv.nix-direnv.enable = true;

  programs.direnv.enableNushellIntegration = false;
}
