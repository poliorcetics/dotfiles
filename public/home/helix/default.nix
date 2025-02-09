# Helix configuration
#
# <https://helix-editor.com/>
#
# I always use latest master so docs are at <https://docs.helix-editor.com/master/>.

{ config, ... }:
{
  programs.helix.enable = true;

  programs.helix.languages = import ./languages.nix config;
  programs.helix.settings = import ./config.nix;
  programs.helix.themes.poliorcetics = import ./theme.nix;

  # Helix-specific ignore file
  programs.helix.ignores = [
    # VCS
    ".git"
    ".jj"

    # Direnv
    ".direnv"

    # Python
    ".mypy_cache"
    ".pytest_cache"
    ".ruff_cache"
    "__pycache__"
  ];
}
