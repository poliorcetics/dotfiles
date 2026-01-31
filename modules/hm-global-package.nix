{
  config,
  lib,
  ...
}:
let
  inherit (config.personal) global-packages;

  runLines = lib.pipe global-packages [
    (builtins.mapAttrs (name: value: /* bash */ ''run link-if-possible "${name}" "${value}"''))
    builtins.attrValues
    lib.concatLines
  ];
in
{
  options.personal.global-packages = lib.mkOption {
    type = lib.types.attrsOf lib.types.str;
    description = ''
      Packages to link globally in `/usr/bin/`.

      Will fail if the name already exists and is not a link to the nix store.
    '';
    default = { };
  };

  config = lib.mkIf (builtins.length (builtins.attrNames global-packages) != 0) {
    home.activation.global-packages = /* bash */ ''
      function link-if-possible {
        local target="/usr/bin/$1"
        local source="$2"

        if [[ -e "$target" ]]; then
          local targetRealPath
          targetRealPath="$(realpath "$target")"

          if [[ ! -f "$targetRealPath" ]]; then
            echo "Not a file: $target (-> $targetRealPath)" >&2
            exit 1
          fi

          if [[ ! -x "$targetRealPath" ]]; then
            echo "Not an executable: $target (-> $targetRealPath)" >&2
            exit 1
          fi

          if [[ "$targetRealPath" != /nix/store/* ]]; then
            echo "Not a symlink to the nix store: $target (-> $targetRealPath)" >&2
            exit 1
          fi
        fi

        echo "Linking: $target -> $source"
        ln -sf "$source" "$target"
      }

      ${runLines}
    '';
  };
}
