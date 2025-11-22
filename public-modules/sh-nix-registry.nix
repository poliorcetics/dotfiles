{
  nixpkgs,
  nixpkgs-unstable,
}:
let
  inputs = { inherit nixpkgs nixpkgs-unstable; };
in
{
  nix.registry = rec {
    # Stable goes by two names
    nixpkgs.flake = inputs.nixpkgs;
    stable.flake = inputs.nixpkgs;

    # Installed unstable
    unstable.flake = inputs.nixpkgs-unstable;

    # Actual latest unstable, useful to test things without updating my whole config
    latest = {
      from = {
        type = "indirect";
        id = "latest";
      };
      to = {
        type = "github";
        owner = "nixos";
        repo = "nixpkgs";
        ref = "nixpkgs-unstable";
      };
    };

    # Aliases, for less typing
    l = latest;
    n = nixpkgs;
    s = stable;
    u = unstable;
  };
}
