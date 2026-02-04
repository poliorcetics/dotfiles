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
    "git/config" = "modules/home-manager/program-git/config";
    "git/ignore" = "modules/home-manager/program-git/ignore";
    "git/includes" = "modules/home-manager/program-git/includes";
  };

  xdg.configFile."git/modules/user".text = /* git-config */ ''
    [user]
      email = "${config.personal.public.vcsEmail}"
      name = "${config.personal.public.vcsDisplayName}"
  '';

  xdg.configFile."git/work/user" = lib.mkIf (config.personal.work.vcsEmail != null) {
    text = /* git-config */ ''
      [user]
        email = "${config.personal.work.vcsEmail}"
        name = "${config.personal.work.vcsDisplayName}"
    '';
  };
}
