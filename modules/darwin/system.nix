{
  config,
  ...
}:
{
  # <https://github.com/nix-darwin/nix-darwin/blob/nix-darwin-25.11/modules/system/primary-user.nix>
  system.primaryUser = config.personal.username;
}
