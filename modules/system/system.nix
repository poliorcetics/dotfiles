self: {
  _file = ./system.nix;
  key = ./system.nix;

  system.configurationRevision = self.rev or self.dirtyRev or null;
}
