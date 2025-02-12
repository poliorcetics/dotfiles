# Theme configuration for helix
#
# Usually I would write this directly in TOML, but
#
# 1. I don't change it often
# 2. The helix theme format is extremely bad at reducing duplication
#
# So Nix it is
let
  error = {
    bg = "#cc241d";
    fg = "#cc241d";
  };
  hint = {
    bg = "#475f3c";
    fg = "#93c47d";
  };
  info = {
    bg = "#3d85c6";
    fg = "#3d85c6";
  };
  warning = {
    bg = "#553308";
    fg = "#cc7c1d";
  };
  unnecessary = {
    modifiers = [ "dim" ];
  };
  deprecated = {
    modifiers = [ "crossed_out" ];
  };

  default = {
    fg = "#f3f6f4";
    bg = "#262626";
  };

  cursor = "#15486d";
  cursor_match = "#994591";

  cursorline_primary = "#3b3b3b";
  cursorline_secondary = "#303030";

  help = "#3c3836";

  linenr = "#7c6f64";
  selected = {
    fg = "#fabd2f";
    bg = "#3b3b3b";
  };

  popup = "#504945";

  selection_secondary = "#514425";
  selection_primary = "#786b4a";

  statusline = "#504945";
  statusline_inactive = {
    fg = "#a89984";
    bg = "#0c0c0c";
  };

  mode = {
    bg = "#665c54";
  };
  mode_insert = "#8ec07c";
  mode_normal = "#d3869b";
  mode_select = "#fabd2f";

  text = "#ebdbb2";
  text_inactive = "#867a69";

  indent_guide = "#92886f";
  whitespace = "#4c4638";

  inlay_hint = {
    fg = "#7F7F7F";
    bg = "#161616";
  };

  inline_diagnostics = {
    bg = "#1e1e1e";
  };

  # Markup
  heading = "#fb4934";
  markup_raw = "#e69138";

  # Language
  attribute = "#e69138";
  comment = "#9c8f81";
  comment_doc = "#e69138";
  constant = "#d3869b";
  diff_delta = "#ce7e00";
  diff_minus = "#f44336";
  diff_moved = "#ca4191";
  diff_plus = "#8fce00";
  field = "#83a598";
  function = "#b8bb26";
  keyword = "#fb4934";
  kw_return = "#d36c93";
  label = "#d3869b";
  link_text = "#b8bb26";
  link_url = "#6fa8dc";
  macro = "#8ec07c";
  markup_list = "#d3869b";
  markup_quote = "#93c47d";
  namespace = "#93c47d";
  operator = "#d3869b";
  special = "#d36c93";
  string = "#b8bb26";
  type = "#fabd2f";

  # Placeholder for testing
  placeholder = {
    fg = "#ff74f2";
    bg = "#6a329f";
  };

  mod_bold.modifiers = [ "bold" ];
  mod_underline.underline.style = "line";
in
{
  "diagnostic.error" = {
    underline = {
      inherit (mod_underline.underline) style;
      color = error.fg;
    };
  } // mod_bold;
  "diagnostic.hint" = {
    underline = {
      inherit (mod_underline.underline) style;
      color = hint.fg;
    };
  } // mod_bold;
  "diagnostic.info" = {
    underline = {
      inherit (mod_underline.underline) style;
      color = info.fg;
    };
  } // mod_bold;
  "diagnostic.warning" = {
    underline = {
      inherit (mod_underline.underline) style;
      color = warning.fg;
    };
  } // mod_bold;
  "diagnostic.unnecessary" = unnecessary;
  "diagnostic.deprecated" = deprecated;
  "error" = {
    inherit (error) fg;
    inherit (inline_diagnostics) bg;
  };
  "hint" = {
    inherit (hint) fg;
    inherit (inline_diagnostics) bg;
  };
  "info" = {
    inherit (info) fg;
    inherit (inline_diagnostics) bg;
  };
  "warning" = {
    inherit (warning) fg;
    inherit (inline_diagnostics) bg;
  };
  "ui" = {
    inherit (default) bg;
    fg = text;
  };
  "ui.background" = {
    inherit (default) bg;
  };
  "ui.bufferline" = {
    inherit (statusline_inactive) bg;
    fg = text;
  };
  "ui.bufferline.active" = {
    fg = text;
    bg = statusline;
  } // mod_bold;
  "ui.bufferline.background" = {
    inherit (default) bg;
  };
  "ui.cursor" = {
    bg = cursor;
  };
  "ui.cursor.match" = {
    bg = cursor_match;
  };
  "ui.cursor.primary" = {
    modifiers = [ "reversed" ];
  };
  "ui.cursorline.primary" = {
    bg = cursorline_primary;
  };
  "ui.cursorline.secondary" = {
    bg = cursorline_secondary;
  };
  "ui.gutter.selected" = {
    inherit (selected) bg;
  };
  "ui.help" = {
    bg = help;
  };
  "ui.highlight" = {
    bg = cursorline_primary;
  };
  "ui.linenr" = linenr;
  "ui.linenr.selected" = selected;
  "ui.menu" = {
    fg = text;
    bg = popup;
  };
  "ui.menu.scroll" = {
    fg = text;
    bg = popup;
  };
  "ui.menu.selected" = selected;
  "ui.picker.header.column" = {
    fg = text;
  } // mod_underline;
  "ui.picker.header.column.active" = {
    inherit (selected) fg;
  } // mod_underline;
  "ui.popup" = {
    fg = text;
    bg = popup;
  };
  "ui.selection" = {
    bg = selection_secondary;
  };
  "ui.selection.primary" = {
    bg = selection_primary;
  };
  "ui.statusline" = {
    fg = text;
    bg = statusline;
  };
  "ui.statusline.inactive" = statusline_inactive;
  "ui.statusline.insert" = {
    inherit (mode) bg;
    fg = mode_insert;
  } // mod_bold;
  "ui.statusline.normal" = {
    inherit (mode) bg;
    fg = mode_normal;
  } // mod_bold;
  "ui.statusline.select" = {
    inherit (mode) bg;
    fg = mode_select;
  } // mod_bold;
  "ui.statusline.separator" = text;
  "ui.text" = text;
  "ui.text.directory" = special;
  "ui.text.focus" = selected;
  "ui.text.inactive" = text_inactive;
  "ui.text.info" = text;
  "ui.virtual" = {
    inherit (inline_diagnostics) bg;
  };
  "ui.virtual.indent-guide" = indent_guide;
  "ui.virtual.inlay-hint" = inlay_hint;
  "ui.virtual.jump-label" = {
    fg = mode_normal;
    bg = statusline;
  } // mod_bold;
  "ui.virtual.ruler" = {
    bg = cursorline_primary;
  };
  "ui.virtual.whitespace" = whitespace;
  "ui.virtual.wrap" = inlay_hint;
  "ui.window" = text;

  # Mixed Keys (UI & languages)

  "markup" = text;
  "markup.heading" = {
    fg = heading;
  } // mod_bold;
  "markup.raw" = markup_raw;
  "markup.raw.inline" = markup_raw;

  # Language-only Keys

  "attribute" = attribute;
  "boolean" = {
    fg = constant;
  } // mod_bold;
  "clean" = keyword;
  "comment" = comment;
  "comment.block.documentation" = comment_doc;
  "comment.documentation" = comment_doc;
  "constant" = constant;
  "constant.builtin.boolean" = {
    fg = constant;
  } // mod_bold;
  "constant.character.escape" = {
    fg = text;
  } // mod_bold;
  "constructor" = macro;
  "diff.delta" = diff_delta;
  "diff.delta.moved" = diff_moved;
  "diff.minus" = diff_minus;
  "diff.plus" = diff_plus;
  "embedded" = keyword;
  "exception" = {
    fg = keyword;
  } // mod_underline;
  "field" = field;
  "file" = {
    fg = string;
  } // mod_underline;
  "function" = function;
  "function.macro" = macro;
  "identifier" = text;
  "include" = keyword;
  "keyword" = keyword;
  "keyword.control.exception" = kw_return;
  "keyword.control.return" = kw_return;
  "keyword.directive" = attribute;
  "keyword.special" = special;
  "keyword.storage.modifier.mut" = {
    fg = keyword;
  } // mod_underline;
  "label" = label;
  "markup.bold" = mod_bold;
  "markup.inline" = markup_raw;
  "markup.italic" = {
    modifiers = [ "italic" ];
  };
  "markup.label" = label;
  "markup.link.label" = label;
  "markup.link.text" = link_text;
  "markup.link.uri" = link_url;
  "markup.link.url" = link_url;
  "markup.list" = markup_list;
  "markup.quote" = markup_quote;
  "markup.raw.block" = markup_raw;
  "markup.strikethrough" = {
    modifiers = [ "crossed_out" ];
  };
  "markup.underlined" = mod_underline;
  "namespace" = namespace;
  "none" = text;
  "number" = constant;
  "operator" = operator;
  "parameter" = text;
  "punctuation" = attribute;
  "punctuation.special" = {
    fg = attribute;
  } // mod_bold;
  "special" = {
    fg = special;
  } // mod_bold;
  "string" = string;
  "string.escape" = {
    fg = text;
  } // mod_bold;
  "string.regexp" = {
    fg = text;
  } // mod_bold;
  "string.special" = {
    fg = special;
  } // mod_underline;
  "string.special.path" = special;
  "symbol" = {
    inherit (placeholder) bg;
  };
  "tag" = keyword;
  "tag.error" = error.fg;
  "text" = text;
  "time" = {
    modifiers = [ "italic" ];
  };
  "type" = type;
  "variable" = text;
  "variable.builtin" = keyword;
  "variable.other.member" = field;
}
