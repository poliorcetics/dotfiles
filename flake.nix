{
  description = "Poliorcetics' macOS config";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-25.05";
    # Very useful for getting recent packages, try not to use it otherwise,
    nixpkgs-unstable.url = "github:NixOS/nixpkgs/nixpkgs-unstable";

    # Home manager `master` branch follows nixpkgs-stable.
    home-manager = {
      url = "github:nix-community/home-manager/release-25.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # nix-darwin is for macos
    nix-darwin = {
      url = "github:nix-darwin/nix-darwin/nix-darwin-25.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # Format everything with only `nix fmt`
    treefmt = {
      url = "github:numtide/treefmt-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs =
    {
      nixpkgs,
      self,
      treefmt,
      ...
    }@inputs:
    let
      recursiveMerge = nixpkgs.lib.foldr nixpkgs.lib.recursiveUpdate { };
    in
    recursiveMerge [
      {
        # Build darwin flake using:
        # $ darwin-rebuild build --flake .#mac
        darwinConfigurations.mac = import ./. inputs "aarch64-darwin";
        checks.aarch64-darwin.macos-darwin-system = self.darwinConfigurations.mac.system;

        homeConfigurations.linux = import ./. inputs "aarch64-linux";
        checks.aarch64-linux.linux-hm-system = self.homeConfigurations.linux.activationPackage;
      }

      {
        formatter =
          let
            # TODO: treefmt is in regular nixpkgs, look into using that
            makeFmt = system: {
              ${system} =
                (treefmt.lib.evalModule (import nixpkgs { inherit system; }) {
                  programs.mdformat.enable = true;
                  programs.nixfmt.enable = true;
                  # NOTE: no `nufmt`, it's entirely broken
                  programs.ruff-format.enable = true;
                  programs.shfmt.enable = true;
                  programs.taplo.enable = true;
                  programs.yamlfmt.enable = true;
                }).config.build.wrapper;
            };
          in
          makeFmt "aarch64-darwin" // makeFmt "aarch64-linux" // makeFmt "x86_64-linux";
      }
    ];
}
