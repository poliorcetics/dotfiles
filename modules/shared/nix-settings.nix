{
  config,
  ...
}:
{
  nix.settings = {
    # Necessary for using flakes.
    experimental-features = "nix-command flakes";
    trusted-users = [ config.personal.username ];
  };
}
