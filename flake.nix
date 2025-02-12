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

  outputs =
    {
      self,
      home-manager,
      nix-darwin,
      nixpkgs,
      ...
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

      mac = nix-darwin.lib.darwinSystem {
        system = "aarch64-darwin";
        modules = [
          home-manager.darwinModules.home-manager

          ./darwin-configuration.nix

          {
            # <https://nix-community.github.io/home-manager/index.xhtml#sec-flakes-nix-darwin-module> 
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = false;

            home-manager.users.${userDetails.username} = import ./home;
            # Pass arguments to home.nix
            home-manager.extraSpecialArgs.userDetails = userDetails;
          }
        ];
        specialArgs = {
          inherit self userDetails;
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
