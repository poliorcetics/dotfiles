# Language config for helix
{
  config,
  lib,
  pkgs,
  userDetails,
  ...
}:
let
  indent = {
    tab-width = 4;
    unit = "    ";
  };
in
{
  language-server = {
    clangd.args = [ "--background-index" ];

    nixd = {
      command = "nixd";
      args = [ "--inlay-hints" ];

      # <https://github.com/nix-community/nixd/blob/main/nixd/docs/configuration.md>
      # By default there is no home-manager options completion, thus you can add this entry.
      # TODO: make this work on Linux
      config.home-manager.expr = ''(builtins.getFlake "${userDetails.home}/.config/home-manager").darwinConfigurations.mac.options'';
    };

    rust-analyzer.config = {
      # Use in local configs:
      #
      #: check.targets = [
      #:   "aarch64-apple-darwin",
      #:   "x86_64-pc-windows-msvc",
      #:   "x86_64-unknown-linux-musl",
      #: ]
      #:
      #: cargo.target = "x86_64-unknown-linux-musl"
      #: cargo.target = "x86_64-pc-windows-msvc"
      #: cargo.target = "aarch64-apple-darwin"

      assist.importGranularity = "module";
      cargo.extraEnv."CARGO_TARGET_DIR" = "${config.xdg.cacheHome}/rust-analyzer-target-dir";
      # A little slower than a simple check, but so useful
      check.command = "clippy";
      completion.fullFunctionSignatures.enable = true;
      hover.actions.references.enable = true;
      lens.references = {
        adt.enable = true;
        enumVariant.enable = true;
        method.enable = true;
        trait.enable = true;
      };

      inlayHints = {
        closingBraceHints.minLines = 10;
        closureReturnTypeHints.enable = "with_block";
        discriminantHints.enable = "fieldless";
        lifetimeElisionHints.enable = "skip_trivial";
        typeHints.hideClosureInitialization = false;
        # Reborrows and such
        expressionAdjustmentHints.enable = "never";
        expressionAdjustmentHints.hideOutsideUnsafe = false;
        expressionAdjustmentHints.mode = "prefer_prefix";
      };

      # I have beefy machines, let's use them
      lruCapacity = 256;
      workspace.symbol.search = {
        limit = 128;
        kind = "all_symbols";
        scope = "workspace";
      };

      diagnostics.disabled = [
        "inactive-code"
        "inactive_code"
        "unresolved-proc-macro"
        "unresolved_proc_macro"
      ];
    };

    yaml-language-server.config.yaml.keyOrdering = false;
  };

  language = [
    {
      name = "bash";
      inherit indent;
    }

    {
      name = "c";
      inherit indent;
    }

    {
      name = "just";
      auto-format = false;
      inherit indent;
    }

    {
      name = "markdown";
      text-width = 150;

      soft-wrap.enable = true;
      soft-wrap.wrap-at-text-width = true;
    }

    {
      name = "nix";
      auto-format = false;
      formatter.command = "nixfmt";
      language-servers = [ "nixd" ];
    }

    {
      name = "nu";
      inherit indent;
    }

    {
      name = "protobuf";
      inherit indent;
    }

    {
      name = "toml";
      auto-format = false;
      inherit indent;
    }
  ];
}
