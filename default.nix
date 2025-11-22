{
  home-manager,
  nix-darwin,
  nixpkgs,
  nixpkgs-unstable,
  ...
}@inputs:
system:
let
  platform =
    {
      aarch64-darwin = "darwin";
      aarch64-linux = "linux";
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
      darwin.home = "/Users/${userDetails'.username}";
      linux.home = "/home/${userDetails'.username}";
    }
    .${platform};

  specialArgs = rec {
    inherit inputs userDetails;
    unstablePkgs = import nixpkgs-unstable {
      inherit system;
    };
    # Makes an out-of-store symlink from `XDG_CONFIG_HOME/{target}` to `{dotfilesDir}/${source}`.
    #
    # Used as:
    #
    # ```
    # imports = [
    #   (mkConfigLink { force = true; } "gh/config.yml" "config.yml")
    #   (mkConfigLink { } "gh/hosts.yml" "hosts.yml")
    # ];
    # ```
    mkConfigLink =
      {
        force ? false,
      }:
      target: source:
      {
        config,
        lib,
        userDetails,
        ...
      }:
      {
        xdg.configFile."${target}".source = (if force then lib.mkForce else lib.id) (
          config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/${userDetails.dotfilesSubDir}/${source}"
        );
      };
    # Makes an out-of-store symlink from `XDG_CONFIG_HOME/{program}/{file}`
    # to `{dotfilesDir}/public/home/programs/${program}/${file}`.
    #
    # Specialized version of `mkConfigLink`.
    #
    # Used as:
    #
    # ```
    # imports = [
    #   (mkProgramFile { force = true; } "gh" "config.yml")
    #   (mkProgramFile { } "gh" "hosts.yml")
    # ];
    # ```
    mkProgramFile =
      {
        force ? false,
        kind ? "public",
      }:
      program: file:
      mkConfigLink { inherit force; } "${program}/${file}" "${kind}/home/programs/${program}/${file}";
  };

  systemModules = [
    (import ./public-modules/sh-nix-registry.nix { inherit nixpkgs nixpkgs-unstable; })
    (import ./public-modules/sh-nix-settings.nix { inherit userDetails; })

    ./public-modules/sh-nix-gc.nix
    ./public-modules/sh-nix-package.nix

    (import ./public-modules/sy-user.nix { inherit (userDetails) home username; })
    (import ./public-modules/sy-system.nix { inherit (inputs) self; })
  ]
  ++ builtins.filter filterPaths [
    ./public/system/${platform}
    ./work/system/common
    ./work/system/${platform}
  ];

  macosHmModules = builtins.filter filterPaths [
    ./public/home
    ./work/home
  ];

  linuxHmModules = [
    (import ./public-modules/sh-nix-registry.nix { inherit nixpkgs nixpkgs-unstable; })
    (import ./public-modules/sh-nix-settings.nix { inherit userDetails; })

    ./public-modules/sh-nix-gc.nix
    ./public-modules/sh-nix-package.nix
  ]
  ++ builtins.filter filterPaths [
    ./public/home
    ./work/home
  ];

  darwinFullSystem = nix-darwin.lib.darwinSystem {
    inherit specialArgs system;
    modules = systemModules ++ [
      home-manager.darwinModules.home-manager

      # Configure home-manager to pick up both the public and work configurations (if they exist)
      # <https://nix-community.github.io/home-manager/index.xhtml#sec-flakes-nix-darwin-module>
      {
        # <https://nix-community.github.io/home-manager/nixos-options.xhtml#nixos-opt-home-manager.useGlobalPkgs>
        home-manager.useGlobalPkgs = true;
        # Don't allow `users.users.<name>.packages = [ ... ]`, it avoids surprises like adding a
        # package for only one user.
        # <https://nix-community.github.io/home-manager/nixos-options.xhtml#nixos-opt-home-manager.useUserPackages>
        home-manager.useUserPackages = false;

        home-manager.users.${userDetails.username}.imports = macosHmModules;
        # Pass arguments to home.nix
        home-manager.extraSpecialArgs = specialArgs;
      }
    ];
  };

  linuxHmSystem = home-manager.lib.homeManagerConfiguration {
    pkgs = import nixpkgs { inherit system; };
    modules = linuxHmModules;
    extraSpecialArgs = specialArgs;
  };

  finalSystem =
    {
      darwin = darwinFullSystem;
      linux = linuxHmSystem;
    }
    .${platform};
in
finalSystem
