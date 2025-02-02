# GitHub tool configuration
#
# <https://cli.github.com/manual/>

{
  mkProgramFile,
  ...
}:
{
  imports = [
    (mkProgramFile { force = true; } "gh" "config.yml")
    (mkProgramFile { } "gh" "hosts.yml")
  ];

  programs.gh.enable = true;
}
