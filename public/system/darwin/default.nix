{
  imports = [
    ./homebrew.nix
  ];

  # The platform the configuration will be used on.
  nixpkgs.hostPlatform = "aarch64-darwin";

  # Default shell on macOS
  programs.zsh.enable = true;

  # Technically a GC config but not under nix.gc.
  # Disabled after <https://github.com/NixOS/nix/issues/7273>.
  nix.settings.auto-optimise-store = false;
}
