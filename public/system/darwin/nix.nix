{
  # Technically a GC config but not under nix.gc.
  # Disabled after <https://github.com/NixOS/nix/issues/7273>.
  nix.settings.auto-optimise-store = false;

  # <https://github.com/nix-darwin/nix-darwin/blob/nix-darwin-25.05/modules/services/nix-gc/default.nix>
  nix.gc.interval = {
    Weekday = 7;
    Hour = 23;
    Minute = 59;
  };

  # <https://github.com/nix-darwin/nix-darwin/blob/nix-darwin-25.05/modules/services/nix-optimise/default.nix>
  nix.optimise.interval = {
    Weekday = 7;
    Hour = 23;
    Minute = 59;
  };
}
