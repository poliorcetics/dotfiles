# Atuin configuration
#
# <https://atuin.sh>
unstablePkgs: {
  _file = ./default.nix;
  key = ./default.nix;

  programs.atuin.enable = true;
  programs.atuin.package = unstablePkgs.atuin;

  personal.links."atuin/config.toml" = "modules/home-manager/program-atuin/config.toml";
}
