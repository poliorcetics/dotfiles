{
  config,
  lib,
  ...
}:
let
  linkSubmodule = lib.types.submodule (
    { ... }:
    {
      options = {
        target = lib.mkOption {
          type = lib.types.nonEmptyStr;
        };
        force = lib.mkOption {
          type = lib.types.bool;
          default = false;
        };
      };
    }
  );

  linkedFiles = lib.mapAttrs (
    name: value:
    let
      target' = value.target or value;
      force = value.force or false;

      target = "${config.personal.dotfilesDir}/${target'}";
      link = lib.info "${name} -> ${target}" target;
    in
    (if force then lib.mkForce else lib.id) {
      source = config.lib.file.mkOutOfStoreSymlink link;
    }
  ) config.personal.links;
in
{
  options.personal.links = lib.mkOption {
    type = lib.types.attrsOf (lib.types.either lib.types.nonEmptyStr linkSubmodule);
    default = { };
    description = ''
      Configuration symlinked from dotfiles dir to XDG Config Home.
    '';
    example = {
      "gh/config.yml" = "modules/hm-program-gh/config.yml";
      "gh/hosts.yml" = {
        target = "modules/hm-program-gh/hosts.yml";
        force = true;
      };
    };
  };

  config = {
    xdg.configFile = linkedFiles;
  };
}
