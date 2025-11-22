{
  self,
  username,
}:
{
  lib,
  pkgs,
  ...
}:
let
  inherit (pkgs.stdenv) isDarwin isLinux;
  inherit (lib) mkIf mkMerge;
in
{
  system.configurationRevision = self.rev or self.dirtyRev or null;

  # <https://github.com/nix-darwin/nix-darwin/blob/nix-darwin-25.05/modules/system/primary-user.nix>
  system.primaryUser = mkIf isDarwin username;

  system.stateVersion = mkMerge [
    # Used for backwards compatibility, please read the changelog before changing.
    # $ darwin-rebuild changelog
    # <https://github.com/nix-darwin/nix-darwin/blob/nix-darwin-25.05/modules/system/version.nix#L34>
    (mkIf isDarwin 4)

    (mkIf isLinux "25.05")
  ];
}
