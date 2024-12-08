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
    ../common/nix.nix

    ./homebrew.nix
  ];

  users.users.${username} = {
    inherit (userDetails) home;
    name = username;
  };

  # Default shell on macOS
  programs.zsh.enable = true;

  # Set Git commit hash for darwin-version.
  system.configurationRevision = self.rev or self.dirtyRev or null;
  # Used for backwards compatibility, please read the changelog before changing.
  # $ darwin-rebuild changelog
  system.stateVersion = 4;
}
