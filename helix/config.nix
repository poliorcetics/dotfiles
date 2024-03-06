# Helix `config.toml`

{ ... }:
{
  theme = "poliorcetics";

  editor = {
    # === Basics ===
    color-modes = true;
    completion-replace = true;
    completion-trigger-len = 1;
    cursorline = true;
    idle-timeout = 250;
    completion-timeout = 50;
    line-number = "absolute";
    mouse = false;
    # preview-completion-insert = false;
    rulers = [100 120 150];

    # === LSP ===
    lsp.display-inlay-hints = true;

    # === File Picker ===
    file-picker.hidden = false;

    # === Whitespaces ===
    whitespace.render = {
      space = "all";
      tab = "all";
      newline = "none";
    };

    # === Indent guides ===
    indent-guides = {
      render = true;
      character = "▏";
    };

    # === Statusline ===
    statusline = {
      left = [
          "mode"
          "spinner"
          "read-only-indicator"
          "file-modification-indicator"
          "file-name"
          "spacer"
          "diagnostics"
          "spacer"
          "workspace-diagnostics"
          "register"
      ];
      center = [ "version-control" ];
      right = [
          "file-encoding"
          "file-type"
          "separator"
          "selections"
          "separator"
          "primary-selection-length"
          "separator"
          "position"
          "separator"
          "spacer"
          "position-percentage"
          "total-line-numbers"
      ];
    };
  };

  # === Keys ===
  keys = {
    normal = {
      S-up = "jump_view_up";
      S-down = "jump_view_down";
      S-right = "jump_view_right";
      S-left = "jump_view_left";

      A-S-up = "swap_view_up";
      A-S-down = "swap_view_down";
      A-S-right = "swap_view_right";
      A-S-left = "swap_view_left";

      space = {
        n = "file_picker_in_current_buffer_directory";
        h = "file_picker_in_current_directory";

        t = "workspace_diagnostics_picker";
        z = "workspace_symbol_picker";

        "," = "command_palette";
        ":" = "global_search";
        c = ["kill_to_line_end" "insert_mode"];
        m = "select_references_to_symbol_under_cursor";
      };

      g = {
        up = "goto_first_diag";
        down = "goto_last_diag";
        right = "goto_next_diag";
        left = "goto_prev_diag";
      };

      "'" = {
        up = "goto_first_change";
        down = "goto_last_change";
        right = "goto_next_change";
        left = "goto_prev_change";
      };

      "`" = {
        up = "goto_first_change";
        down = "goto_last_change";
        right = "goto_next_change";
        left = "goto_prev_change";
      };

      "]" = {
        d = "no_op";
        D = "no_op";
        g = "no_op";
        G = "no_op";
        space = "no_op";
      };

      "[" = {
        d = "no_op";
        D = "no_op";
        g = "no_op";
        G = "no_op";
        space = "no_op";
      };
    };

    insert = {
      up = "no_op";
      down = "no_op";
      left = "no_op";
      right = "no_op";
      pageup = "no_op";
      pagedown = "no_op";
      home = "no_op";
      end = "no_op";
    };
  };
}
