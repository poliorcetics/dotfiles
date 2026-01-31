# Topgrade configuration
#
# <https://github.com/topgrade-rs/topgrade>
{
  config,
  ...
}:
{
  programs.topgrade.enable = true;

  personal.links."topgrade.toml" = "modules/hm-program-topgrade/config.toml";

  xdg.configFile."topgrade.d/helix.toml".text =
    let
      helixRepo = "${config.xdg.cacheHome}/helix-repo";
      helixTarget = "${config.xdg.cacheHome}/target-dirs/topgrade/helix-repo";
    in
    /* toml */ ''
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
