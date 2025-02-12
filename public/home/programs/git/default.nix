# Git configuration
#
# <https://git-scm.com/>
{
  lib,
  mkProgramFile,
  userDetails,
  ...
}:
{
  imports = [
    (mkProgramFile { } "git" "config")
    (mkProgramFile { } "git" "ignore")
    (mkProgramFile { } "git" "includes")
  ];

  programs.git.enable = true;
  programs.git.lfs.enable = true;

  xdg.configFile."git/public/user".text = ''
    [user]
      email = "${userDetails.public.email}"
      name = "${userDetails.public.displayName}"
  '';

  xdg.configFile."git/work/user" = lib.mkIf (userDetails ? work) {
    text = ''
      [user]
        email = "${userDetails.work.email}"
        name = "${userDetails.work.displayName}"
    '';
  };
}
