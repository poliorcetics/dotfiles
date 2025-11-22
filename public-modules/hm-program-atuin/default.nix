# Atuin configuration
#
# <https://atuin.sh>
{
  mkProgramFile,
  unstablePkgs,
}:
{
  imports = [
    (mkProgramFile { } "atuin" "config.toml")
  ];

  programs.atuin.enable = true;
  programs.atuin.package = unstablePkgs.atuin;
}
