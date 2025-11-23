{
  config,
  ...
}:
{
  # <https://github.com/nix-darwin/nix-darwin/blob/nix-darwin-25.05/modules/system/primary-user.nix>
  system.primaryUser = config.personal.username;

  # Used for backwards compatibility, please read the changelog before changing.
  # $ darwin-rebuild changelog
  # <https://github.com/nix-darwin/nix-darwin/blob/nix-darwin-25.05/modules/system/version.nix#L34>
  system.stateVersion = 4;
}
