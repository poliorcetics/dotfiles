{
  self,
  userDetails,
  ...
}:
let
  username = userDetails.username;
in
{
  imports = [
    ./nix.nix
  ];

  users.users.${username} = {
    inherit (userDetails) home;
    name = username;
  };

  # Set Git commit hash for darwin-version.
  system.configurationRevision = self.rev or self.dirtyRev or null;
  # Used for backwards compatibility, please read the changelog before changing.
  # $ darwin-rebuild changelog
  system.stateVersion = 4;
}
