# Helix configuration
#
# <https://helix-editor.com/>
#
# I always use latest master so docs are at <https://docs.helix-editor.com/master/>.
{
  mkProgramFile,
}:
{
  imports = [
    (mkProgramFile { } "helix" "ignore")
    (mkProgramFile { } "helix" "config.toml")
    (mkProgramFile { } "helix" "languages.toml")
    (mkProgramFile { } "helix" "themes/poliorcetics.toml")
  ];
}
