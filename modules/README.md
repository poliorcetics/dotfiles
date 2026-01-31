# Public Modules

Organisation:

- `hm-*`: modules to be used with `home-manager` (user level),
- `sh-*`: modules that can be used at the system and user levels,
- `sy-*`: modules that can be used with both `nix-darwin` and `nixos` (system level),

Both system and user level modules can always be imported on all platforms, they will use `lib.mkIf` to on activate as necessary.
Shared modules will be imported either at system or user level in their respective machine files.
