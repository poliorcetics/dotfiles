# Jujutsu configuration
#
# <https://github.com/jj-vcs/jj>
{
  config,
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

  # When this variable is a directory, JJ reads all files inside as a single config
  home.sessionVariables.JJ_CONFIG = "${config.xdg.configHome}/jj/";

  home.packages = [ unstablePkgs.jujutsu ];

  xdg.configFile."jj/default-user.toml".text = ''
    [user]
    email = "${userDetails.public.email}"
    name = "${userDetails.public.displayName}"
  '';

  xdg.configFile."jj/work-user.toml" = lib.mkIf (userDetails ? work) {
    text = ''
      [[--scope]]
      --when.repositories = ["~/repos/work"]
      [--scope.user]
      email = "${userDetails.work.email}"
      name = "${userDetails.work.displayName}"
    '';
  };
}
