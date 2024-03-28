# Bacon configuration
#
# <https://dystroy.org/bacon/>

{ ... }:
{
  programs.bacon.enable = true;

  # Settings: <https://dystroy.org/bacon/#global-preferences>
  programs.bacon.settings = {
    summary = true;
    wrap = true;
  };
}
