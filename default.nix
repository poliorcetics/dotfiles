{
  home-manager,
  nix-darwin,
  nixpkgs,
  nixpkgs-unstable,
  self,
  ...
}:
system:
let
  platform =
    {
      aarch64-darwin = "darwin";
      x86_64-darwin = "darwin";
      aarch64-linux = "linux";
      x86_64-linux = "linux";
    }
    .${system};

  filterPaths = path: builtins.pathExists "${builtins.toString path}/default.nix";

  # Merge user details, favoritizing work ones
  userDetails' =
    builtins.foldl' (acc: p: if builtins.pathExists p then acc // (import p) else acc) { }
      [
        ./public/user.nix
        ./work/user.nix
      ];
  # Adapt the home path to the platform
  userDetails =
    userDetails'
    // {
      darwin.home = "/Users/${userDetails.username}";
      linux.home = "/home/${userDetails.username}";
    }
    .${platform};

  specialArgs = {
    inherit self userDetails;
    unstablePkgs = import nixpkgs-unstable {
      inherit system;
    };
  };

  systemModules = builtins.filter filterPaths [
    ./public/system/common
    ./public/system/${platform}
    ./work/system/common
    ./work/system/${platform}
  ];

  mkSystem =
    {
      darwin = nix-darwin.lib.darwinSystem;
      linux = nixpkgs.lib.nixosSystem;
    }
    .${platform};
in
mkSystem {
  inherit specialArgs system;
  modules = systemModules ++ [
    {
      darwin = home-manager.darwinModules.home-manager;
      linux = home-manager.nixosModules.home-manager;
    }
    .${platform}

    {
      # <https://nix-community.github.io/home-manager/index.xhtml#sec-flakes-nix-darwin-module>
      home-manager.useGlobalPkgs = true;
      home-manager.useUserPackages = false;

      home-manager.users.${userDetails.username} = {
        imports = builtins.filter filterPaths [
          ./public/home
          ./work/home
        ];
      };
      # Pass arguments to home.nix
      home-manager.extraSpecialArgs = specialArgs;
    }
  ];
}
