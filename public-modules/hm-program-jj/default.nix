# Jujutsu configuration
#
# <https://github.com/jj-vcs/jj>
{
  mkProgramFile,
  unstablePkgs,
}:
{
  config,
  lib,
  ...
}:
{
  imports = [
    (mkProgramFile { } "jj" "config.toml")
  ];

  home.packages = [ unstablePkgs.jujutsu ];

  xdg.configFile."jj/conf.d/00-default-user.toml".text = ''
    [user]
    email = "${config.personal.public.vcsEmail}"
    name = "${config.personal.public.vcsDisplayName}"
  '';

  xdg.configFile."jj/conf.d/00-work-user.toml" = lib.mkIf (config.personal.work.vcsEmail != null) {
    text = ''
      [[--scope]]
      --when.repositories = ["~/repos/work"]
      [--scope.user]
      email = "${config.personal.work.vcsEmail}"
      name = "${config.personal.work.vcsDisplayName}"
    '';
  };
}
