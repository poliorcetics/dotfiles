# GitHub tool configuration
#
# <https://cli.github.com/manual/>

{
  programs.gh.enable = true;

  personal.links = {
    "gh/config.yml" = {
      target = "modules/hm-program-gh/config.yml";
      force = true;
    };
    "gh/hosts.yml" = "modules/hm-program-gh/hosts.yml";
  };
}
