{
  nix.gc = {
    automatic = true;
    options = "--delete-older-than 30d";
  };

  nix.optimise.automatic = true;
}
