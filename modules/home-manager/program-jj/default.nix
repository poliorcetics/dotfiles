# Jujutsu configuration
#
# <https://github.com/jj-vcs/jj>

unstablePkgs:
{
  config,
  lib,
  pkgs,
  ...
}:
let
  jj-fix-nix-fmt = pkgs.writeShellScriptBin "__jj_fix_nix_fmt" ''
    target_path="$1"
    CLICOLOR_FORCE=1 nix fmt --no-update-lock-file "$target_path"
    cat "$target_path"
  '';
in
{
  _file = ./default.nix;
  key = ./default.nix;

  home.packages = [
    unstablePkgs.jujutsu
    jj-fix-nix-fmt
  ];

  personal.links."jj/config.toml" = "modules/home-manager/program-jj/config.toml";

  xdg.configFile."jj/conf.d/00-default-user.toml".text = /* toml */ ''
    [user]
    email = "${config.personal.public.vcsEmail}"
    name = "${config.personal.public.vcsDisplayName}"
  '';

  xdg.configFile."jj/conf.d/00-work-user.toml" = lib.mkIf (config.personal.work.vcsEmail != null) {
    text = /* toml */ ''
      [[--scope]]
      --when.repositories = ["~/repos/work"]
      [--scope.user]
      email = "${config.personal.work.vcsEmail}"
      name = "${config.personal.work.vcsDisplayName}"
    '';
  };
}
