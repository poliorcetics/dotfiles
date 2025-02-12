# GitHub tool configuration
#
# <https://cli.github.com/manual/>

{ ... }:
{
  programs.gh.enable = true;

  programs.gh.settings = {
    aliases = {
      co = "pr checkout";
    };
    editor = "hx";
    git_protocol = "ssh";
    prompt = "enabled";
    version = "1";
  };
}
