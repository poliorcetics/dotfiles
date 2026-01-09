# Jujutsu configuration
#
# <https://github.com/jj-vcs/jj>
{
  unstablePkgs,
}:
{
  config,
  lib,
  ...
}:
{
  home.packages = [ unstablePkgs.jujutsu ];

  personal.links."jj/config.toml" = "public/modules/hm-program-jj/config.toml";

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
