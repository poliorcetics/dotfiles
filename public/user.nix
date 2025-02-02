{
  username = "alexis";
  # Where the dotfiles are in relation to the user's home.
  # Used for `mkOufOfStoreSymlink` (see <https://jeancharles.quillet.org/posts/2023-02-07-The-home-manager-function-that-changes-everything.html>)
  # We need this since, from a flake, it is not possible to get the original path on disk (because that's impure).
  dotfilesSubDir = "repos/me/dotfiles";

  # Intended for Git/JJ configs.
  public = {
    displayName = "Alexis (Poliorcetics) Bourget";
    email = "ab_contribs@poliorcetiq.eu";
  };
}
