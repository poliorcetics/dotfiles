# Themes

Themes for the Bash shell are loaded using the `BASH_THEME` environnement variable. The theme is loaded once at the launch of the shell (not at each invocation of the prompt).

A theme file for bash is a text file with the extension `bash_theme` (this extension only exists to clarify the file's purpose to an observer).

To create a theme, just modify the appropriate variables as shown in the default theme (re-exporting the variables may be necessary).

The default theme is loaded before the (potential) custom theme, meaning setting only part of the variables is not an error and even the recommended way of doing things: less work for you.

**Note:** the default theme is loaded before any customization file, to allow for the variables inside it to be used during customization.
