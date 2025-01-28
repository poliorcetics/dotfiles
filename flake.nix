{
  description = "Poliorcetics' macOS config";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-24.11";
    # Very useful for getting recent packages, try not to use it otherwise,
    nixpkgs-unstable.url = "github:NixOS/nixpkgs/nixpkgs-unstable";

    # Home manager `master` branch follows nixpkgs-unstable.
    home-manager = {
      url = "github:nix-community/home-manager/release-24.11";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # nix-darwin is for macos
    nix-darwin = {
      url = "github:LnL7/nix-darwin/nix-darwin-24.11";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs =
    {
      self,
      home-manager,
      nix-darwin,
      nixpkgs,
      nixpkgs-unstable,
    }:
    let
      # Changing this should be enough to override every places depending on them in the config.
      userDetails = {
        username = "alexis";
        home = "/Users/${userDetails.username}";
        # Intended in Git/JJ configs.
        displayName = "Alexis (Poliorcetics) Bourget";
        email = "ab_contribs@poliorcetiq.eu";
      };

      unstablePkgs = import nixpkgs-unstable {
        system = "aarch64-darwin";
      };

      mac = nix-darwin.lib.darwinSystem {
        system = "aarch64-darwin";
        modules = [
          home-manager.darwinModules.home-manager

          ./system/common
          ./system/darwin

          {
            # <https://nix-community.github.io/home-manager/index.xhtml#sec-flakes-nix-darwin-module>
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = false;

            home-manager.users.${userDetails.username} = import ./home;
            # Pass arguments to home.nix
            home-manager.extraSpecialArgs = {
              inherit userDetails unstablePkgs;
            };
          }
        ];
        specialArgs = {
          inherit self userDetails unstablePkgs;
        };
      };
    in
    {
      # Build darwin flake using:
      # $ darwin-rebuild build --flake .#mac
      darwinConfigurations.mac = mac;

      formatter =
        let
          makeFmt = system: { ${system} = (import nixpkgs { inherit system; }).nixfmt-rfc-style; };
        in
        makeFmt "aarch64-darwin" // makeFmt "aarch64-linux" // makeFmt "x86_64-linux";
    };
}
