{
  imports = [
    ./homebrew.nix
    ./nix.nix
  ];

  # The platform the configuration will be used on.
  nixpkgs.hostPlatform = "aarch64-darwin";

  # Default shell on macOS
  programs.zsh.enable = true;

  # Used for backwards compatibility, please read the changelog before changing.
  # $ darwin-rebuild changelog
  # <https://github.com/nix-darwin/nix-darwin/blob/nix-darwin-24.11/modules/system/version.nix#L34>
  system.stateVersion = 4;
}
