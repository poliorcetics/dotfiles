# Git configuration
#
# <https://git-scm.com/>
{
  config,
  lib,
  ...
}:
{
  programs.git.enable = true;
  programs.git.lfs.enable = true;

  personal.links = {
    "git/config" = "public-modules/hm-program-git/config";
    "git/ignore" = "public-modules/hm-program-git/ignore";
    "git/includes" = "public-modules/hm-program-git/includes";
  };

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
