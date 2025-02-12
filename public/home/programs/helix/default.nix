# Helix configuration
#
# <https://helix-editor.com/>
#
# I always use latest master so docs are at <https://docs.helix-editor.com/master/>.
{
  pkgs,
  mkProgramFile,
  ...
}:
{
  imports = [
    (mkProgramFile { } "helix" "ignore")
    (mkProgramFile { } "helix" "config.toml")
    (mkProgramFile { } "helix" "languages.toml")
  ];

  xdg.configFile."helix/themes/poliorcetics.toml".source =
    (pkgs.formats.toml { }).generate "poliorcetics.toml"
      (import ./theme.nix);
}
