{
  pkgs,
  ...
}:
{
  # Technically a GC config but not under nix.gc.
  # Disabled on macOS after <https://github.com/NixOS/nix/issues/7273>.
  nix.settings.auto-optimise-store = !pkgs.stdenv.isDarwin;
}
