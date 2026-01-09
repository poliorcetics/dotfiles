# GitHub tool configuration
#
# <https://cli.github.com/manual/>

{
  programs.gh.enable = true;

  personal.links = {
    "gh/config.yml" = {
      target = "public/modules/hm-program-gh/config.yml";
      force = true;
    };
    "gh/hosts.yml" = "public/modules/hm-program-gh/hosts.yml";
  };
}
