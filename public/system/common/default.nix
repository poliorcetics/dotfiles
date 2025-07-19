{
  inputs,
  userDetails,
  ...
}:
let
  inherit (userDetails) username;
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
  system.configurationRevision = inputs.self.rev or inputs.self.dirtyRev or null;
}
