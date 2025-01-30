{
  imports = [
    ./homebrew.nix
  ];

  # The platform the configuration will be used on.
  nixpkgs.hostPlatform = "aarch64-darwin";

  # Default shell on macOS
  programs.zsh.enable = true;
}
