# GitHub tool configuration
#
# <https://cli.github.com/manual/>

{
  programs.gh.enable = true;

  personal.links = {
    "gh/config.yml" = {
      target = "modules/home-manager/program-gh/config.yml";
      force = true;
    };
    "gh/hosts.yml" = "modules/home-manager/program-gh/hosts.yml";
  };
}
