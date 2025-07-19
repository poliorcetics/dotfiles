# Jujutsu configuration
#
# <https://github.com/jj-vcs/jj>
{
  lib,
  mkProgramFile,
  unstablePkgs,
  userDetails,
  ...
}:
{
  imports = [
    (mkProgramFile { } "jj" "config.toml")
  ];

  home.packages = [ unstablePkgs.jujutsu ];

  xdg.configFile."jj/conf.d/default-user.toml".text = ''
    [user]
    email = "${userDetails.public.email}"
    name = "${userDetails.public.displayName}"
  '';

  xdg.configFile."jj/conf.d/work-user.toml" = lib.mkIf (userDetails ? work) {
    text = ''
      [[--scope]]
      --when.repositories = ["~/repos/work"]
      [--scope.user]
      email = "${userDetails.work.email}"
      name = "${userDetails.work.displayName}"
    '';
  };
}
