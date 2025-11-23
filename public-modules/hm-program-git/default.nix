# Git configuration
#
# <https://git-scm.com/>
{
  mkProgramFile,
}:
{
  config,
  lib,
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
      email = "${config.personal.public.vcsEmail}"
      name = "${config.personal.public.vcsDisplayName}"
  '';

  xdg.configFile."git/work/user" = lib.mkIf (config.personal.work.vcsEmail != null) {
    text = ''
      [user]
        email = "${config.personal.work.vcsEmail}"
        name = "${config.personal.work.vcsDisplayName}"
    '';
  };
}
