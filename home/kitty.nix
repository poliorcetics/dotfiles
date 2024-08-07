# Kitty configuration
#
# <https://sw.kovidgoyal.net/kitty>
#
# Config docs: <https://sw.kovidgoyal.net/kitty/conf/>

{ config, ... }:
let

  # === Fonts ===
  #
  # Docs: <https://sw.kovidgoyal.net/kitty/conf/#fonts>
  fonts = {
    # <https://sw.kovidgoyal.net/kitty/conf/#opt-kitty.font_family>
    font_family = "Iosevka Custom Regular";
    bold_font = "Iosevka Custom Semibold";
    italic_font = "Iosevka Custom Oblique";
    bold_italic_font = "Iosevka Custom Semibold Oblique";

    # <https://sw.kovidgoyal.net/kitty/conf/#opt-kitty.font_size>
    font_size = 15;

    # <https://sw.kovidgoyal.net/kitty/conf/#opt-kitty.disable_ligatures>
    disable_ligatures = "cursor";
  };

  # === Cursor customization ===
  #
  # Docs: <https://sw.kovidgoyal.net/kitty/conf/#cursor-customization>
  cursor_customization = {
    # <https://sw.kovidgoyal.net/kitty/conf/#opt-kitty.cursor>
    cursor = "#cccccc";

    # <https://sw.kovidgoyal.net/kitty/conf/#opt-kitty.cursor_text_color>
    cursor_text_color = "#111111";
  };

  # === Scrollback ===
  #
  # Docs: <https://sw.kovidgoyal.net/kitty/conf/#scrollback>
  scrollback = {
    # <https://sw.kovidgoyal.net/kitty/conf/#opt-kitty.scrollback_lines>
    scrollback_lines = 10000;

    # <https://sw.kovidgoyal.net/kitty/conf/#opt-kitty.scrollback_pager>
    scrollback_pager = "less --chop-long-lines --RAW-CONTROL-CHARS +INPUT_LINE_NUMBER";
  };

  # === Mouse ===
  #
  # Docs: <https://sw.kovidgoyal.net/kitty/conf/#mouse>
  mouse = {
    # <https://sw.kovidgoyal.net/kitty/conf/#opt-kitty.scrollback_pager>
    copy_on_select = "yes";
  };

  # === Terminal Bell ===
  #
  # Docs: <https://sw.kovidgoyal.net/kitty/conf/#mouse>
  terminal_bell = {
    # <https://sw.kovidgoyal.net/kitty/conf/#opt-kitty.enable_audio_bell>
    enable_audio_bell = "no";
  };

  # === Window layout ===
  #
  # Docs: <https://sw.kovidgoyal.net/kitty/conf/#window-layout>
  window_layout = {
    # <https://sw.kovidgoyal.net/kitty/conf/#opt-kitty.enabled_layouts>
    enabled_layouts = "tall,stack";

    # <https://sw.kovidgoyal.net/kitty/conf/#opt-kitty.window_resize_step_cells>
    window_resize_step_cells = 1;
    window_resize_step_lines = 1;

    # <https://sw.kovidgoyal.net/kitty/conf/#opt-kitty.window_border_width>
    window_border_width = "1.0pt";

    # <https://sw.kovidgoyal.net/kitty/conf/#opt-kitty.window_margin_width>
    window_margin_width = 1;

    # <https://sw.kovidgoyal.net/kitty/conf/#opt-kitty.active_border_color>
    active_border_color = "#009900";

    # <https://sw.kovidgoyal.net/kitty/conf/#opt-kitty.inactive_border_color>
    inactive_border_color = "#3d3d3d";

    # <https://sw.kovidgoyal.net/kitty/conf/#opt-kitty.confirm_os_window_close>
    confirm_os_window_close = 0;
  };

  # === Tab bar ===
  #
  # Docs: <https://sw.kovidgoyal.net/kitty/conf/#tab-bar>
  tab_bar = {
    # <https://sw.kovidgoyal.net/kitty/conf/#opt-kitty.tab_bar_edge>
    tab_bar_edge = "top";

    # <https://sw.kovidgoyal.net/kitty/conf/#opt-kitty.tab_bar_style>
    tab_bar_style = "separator";

    # <https://sw.kovidgoyal.net/kitty/conf/#opt-kitty.tab_bar_min_tabs>
    tab_bar_min_tabs = 1;

    # <https://sw.kovidgoyal.net/kitty/conf/#opt-kitty.tab_separator>
    tab_separator = "\"\"";

    # <https://sw.kovidgoyal.net/kitty/conf/#opt-kitty.tab_title_template>
    tab_title_template = "{index}: {title} ({layout_name[:2].title()})";

    # <https://sw.kovidgoyal.net/kitty/conf/#opt-kitty.active_tab_foreground>
    active_tab_foreground = "#000";
    active_tab_background = "#aaa";
    active_tab_font_style = "normal";
    inactive_tab_foreground = "#8e8e8e";
    inactive_tab_background = "#3d3d3d";
    inactive_tab_font_style = "normal";
  };

  # === Color scheme ===
  #
  # <https://sw.kovidgoyal.net/kitty/conf/#color-scheme>
  color_scheme = {
    # <https://sw.kovidgoyal.net/kitty/conf/#opt-kitty.dynamic_background_opacity>
    dynamic_background_opacity = "yes";
  };

  # === Advanced ===
  #
  # Docs: <https://sw.kovidgoyal.net/kitty/conf/#advanced>
  advanced = {
    # <https://sw.kovidgoyal.net/kitty/conf/#opt-kitty.editor>
    editor = "${config.home.sessionVariables.CARGO_HOME}/bin/hx";
  };

  # === OS specific tweaks ===
  #
  # Docs: <https://sw.kovidgoyal.net/kitty/conf/#os-specific-tweaks>o
  os_specific_tweaks = {
    # <https://sw.kovidgoyal.net/kitty/conf/#opt-kitty.macos_option_as_alt>
    macos_option_as_alt = "right";
  };

  # === Keybindings ===
  #
  # Docs: <https://sw.kovidgoyal.net/kitty/conf/#keyboard-shortcuts>
  keybindings = {
    clear_all_shortcuts = "yes";
  };

  # === KB: clipboard ===
  #
  # Docs: <https://sw.kovidgoyal.net/kitty/conf/#clipboard>
  kb_clipboard = {
    # <https://sw.kovidgoyal.net/kitty/conf/#shortcut-kitty.Copy-to-clipboard>
    "super+c" = "copy_to_clipboard";
    "kitty_mod+c" = "copy_to_clipboard";

    # <https://sw.kovidgoyal.net/kitty/conf/#shortcut-kitty.Paste-from-clipboard>
    "super+v" = "paste_from_clipboard";
    "kitty_mod+v" = "paste_from_clipboard";
  };

  # === KB: scrolling ===
  #
  # Docs: <https://sw.kovidgoyal.net/kitty/conf/#scrolling>
  kb_scrolling = {
    # <https://sw.kovidgoyal.net/kitty/conf/#shortcut-kitty.Browse-scrollback-buffer-in-pager>
    "kitty_mod+h" = "show_scrollback";
  };

  # === KB: window management ===
  #
  # Docs: <https://sw.kovidgoyal.net/kitty/conf/#window-management>
  kb_window_management = {
    # <https://sw.kovidgoyal.net/kitty/conf/#shortcut-kitty.New-window>
    "super+d" = "launch --cwd=current";

    # <https://sw.kovidgoyal.net/kitty/conf/#shortcut-kitty.New-OS-window>
    "super+n" = "new_os_window";

    # <https://sw.kovidgoyal.net/kitty/conf/#shortcut-kitty.Close-window>
    "super+w" = "close_window";

    # <https://sw.kovidgoyal.net/kitty/conf/#shortcut-kitty.Start-resizing-window>
    "super+r" = "start_resizing_window";

    # <https://sw.kovidgoyal.net/kitty/conf/#shortcut-kitty.Close-OS-window>
    "shift+super+w" = "close_os_window";

    # <https://sw.kovidgoyal.net/kitty/actions/#action-move_window>
    "kitty_mod+up" = "move_window up";
    "kitty_mod+left" = "move_window left";
    "kitty_mod+right" = "move_window right";
    "kitty_mod+down" = "move_window down";

    # <https://sw.kovidgoyal.net/kitty/actions/#action-neighboring_window>
    "super+left" = "neighboring_window left";
    "super+right" = "neighboring_window right";
    "super+up" = "neighboring_window up";
    "super+down" = "neighboring_window down";
  };

  # === KB: tab management ===
  #
  # Docs: <https://sw.kovidgoyal.net/kitty/conf/#tab-management>
  kb_tab_management = {
    # <https://sw.kovidgoyal.net/kitty/conf/#shortcut-kitty.Next-tab>
    "super+alt+right" = "next_tab";

    # <https://sw.kovidgoyal.net/kitty/conf/#shortcut-kitty.Previous-tab>
    "super+alt+left" = "previous_tab";

    # <https://sw.kovidgoyal.net/kitty/conf/#shortcut-kitty.New-tab>
    "super+t" = "new_tab";

    # <https://sw.kovidgoyal.net/kitty/conf/#shortcut-kitty.Move-tab-forward>
    "super+:" = "move_tab_forward";

    # <https://sw.kovidgoyal.net/kitty/conf/#shortcut-kitty.Move-tab-backward>
    "super+;" = "move_tab_backward";

    # <https://sw.kovidgoyal.net/kitty/conf/#shortcut-kitty.Set-tab-title>
    "shift+super+t" = "set_tab_title";
  };

  # === KB: layout management ===
  #
  # Docs: <https://sw.kovidgoyal.net/kitty/conf/#layout-management>
  kb_layout_management = {
    # <https://sw.kovidgoyal.net/kitty/conf/#shortcut-kitty.Next-layout>
    "super+l" = "toggle_layout stack";
  };

  # === KB: font sizes ===
  #
  # Docs: <https://sw.kovidgoyal.net/kitty/conf/#font-sizes>
  kb_font_sizes = {
    # <https://sw.kovidgoyal.net/kitty/conf/#shortcut-kitty.Increase-font-size>
    "super+shift+equal" = "change_font_size all +1.0";
    "super+plus" = "change_font_size all +1.0";

    # <https://sw.kovidgoyal.net/kitty/conf/#shortcut-kitty.Decrease-font-size>
    "super+minus" = "change_font_size all -1.0";

    # <https://sw.kovidgoyal.net/kitty/conf/#shortcut-kitty.Reset-font-size>
    "super+=" = "change_font_size all 0";

    # <https://sw.kovidgoyal.net/kitty/conf/#shortcut-kitty.Reset-the-terminal>
    "super+k" = "clear_terminal scroll active";

    # <https://sw.kovidgoyal.net/kitty/conf/#shortcut-kitty.Reload-kitty.conf>
    "ctrl+super+," = "load_config_file";
  };

  # === KB: miscellaneous ===
  #
  # Docs: <https://sw.kovidgoyal.net/kitty/conf/#miscellaneous>
  kb_miscellaneous = {
    # <https://sw.kovidgoyal.net/kitty/conf/#shortcut-kitty.Unicode-input>
    "kitty_mod+u" = "kitten unicode_input";

    # <https://sw.kovidgoyal.net/kitty/conf/#shortcut-kitty.Make-background-fully-opaque>
    "super+u" = "set_background_opacity 0.80";
    "super+shift+u" = "set_background_opacity 1.0";

    # <https://sw.kovidgoyal.net/kitty/conf/#shortcut-kitty.Quit-kitty>
    "super+q" = "quit";
  };

in

{
  programs.kitty.enable = true;

  programs.kitty.darwinLaunchOptions = [ "--start-as=maximized" ];

  programs.kitty.settings =
    fonts
    // cursor_customization
    // scrollback
    // mouse
    // terminal_bell
    // window_layout
    // tab_bar
    // color_scheme
    // advanced
    // os_specific_tweaks
    // keybindings;

  programs.kitty.keybindings =
    kb_clipboard
    // kb_scrolling
    // kb_window_management
    // kb_tab_management
    // kb_layout_management
    // kb_font_sizes
    // kb_miscellaneous;
}
