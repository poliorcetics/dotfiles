{
  description = "Poliorcetics' macOS config";

  inputs = {
    # Unstable branch for the win.
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";

    # Home manager `master` branch follows nixpkgs-unstable.
    home-manager = {
      url = "github:nix-community/home-manager/master";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # nix-darwin is for macos
    nix-darwin = {
      url = "github:LnL7/nix-darwin";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = inputs @ {
    self,
    nixpkgs,
    home-manager,
    nix-darwin,
    ...
  }:

  let
    # Changing this should be enough to override every places depending on them in the config.

    mac = let
      userDetails = {
        username = "alexis";
        home = "/Users/${userDetails.username}";
        # Intended in Git/JJ configs.
        displayName = "Alexis (Poliorcetics) Bourget";
        email = "ab_contribs@poliorcetiq.eu";
      };
    in
      nix-darwin.lib.darwinSystem {
        system = "aarch64-darwin";
        modules = [
          ./darwin-configuration.nix
          home-manager.darwinModules.home-manager
          {
          # <https://nix-community.github.io/home-manager/index.xhtml#sec-flakes-nix-darwin-module> 
          home-manager.useGlobalPkgs = true;
          home-manager.useUserPackages = false;

          home-manager.users.${userDetails.username} = import ./home;
          # Pass arguments to home.nix
          home-manager.extraSpecialArgs = { inherit userDetails; };
          }
        ];
        specialArgs = { inherit self userDetails; };
      };
  in
  {
    # Build darwin flake using:
    # $ darwin-rebuild build --flake .#mac
    darwinConfigurations = { inherit mac; };
    # Expose the package set, including overlays, for convenience.
    darwinPackages = self.darwinConfigurations."mac".pkgs;

    checks.aarch64-darwin.canBuild = mac.system;
  };
}
