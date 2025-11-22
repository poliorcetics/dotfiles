# Topgrade configuration
#
# <https://github.com/topgrade-rs/topgrade>
{ config, mkConfigLink, ... }:
{
  imports = [
    (mkConfigLink { } "topgrade.toml" "public-modules/hm-program-topgrade/config.toml")
  ];

  programs.topgrade.enable = true;

  xdg.configFile."topgrade.d/helix.toml".text =
    let
      helixRepo = "${config.xdg.cacheHome}/helix-repo";
      helixTarget = "${config.xdg.cacheHome}/target-dirs/topgrade/helix-repo";
    in
    ''
      [commands]
      "1. Helix - Install from repo" = """
          cd "${helixRepo}" \
          && RUSTFLAGS="-C target-cpu=native" \
             CARGO_TARGET_DIR="${helixTarget}" \
             cargo +stable install --locked --path helix-term \
          && hx --grammar fetch \
          && hx --grammar build"""

      [git]
      repos = [ "${helixRepo}" ]
    '';
}
