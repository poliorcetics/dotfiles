{
  self,
}:
{
  lib,
  pkgs,
  ...
}:
let
  inherit (pkgs.stdenv) isLinux;
  inherit (lib) mkIf mkMerge;
in
{
  system.configurationRevision = self.rev or self.dirtyRev or null;

  system.stateVersion = mkMerge [
    (mkIf isLinux "25.05")
  ];
}
