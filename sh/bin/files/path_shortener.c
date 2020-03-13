/**
 * Fichier: path_shortener.c
 * Auteur: Alexis Bourget
 */
#include <stdio.h>

/*
 * Raccourci un chemin en place.
 *
 * IMPORTANT:
 *
 *  - Aucun remplacement de '$HOME' vers '~' n'est fait.
 *  - La fin du `path` n'est pas effacé, la chaîne est juste coupée au bon endroit,
 *    à l'aide d'un `\0`.
 *
 * Comportement attendu:
 *
 *  - Les dossiers `name` sont raccourcis en `n`.
 *  - Les dossiers `.name` sont raccourcis en `.n`.
 *  - Les `/` sont conservés, où qu'ils soient dans le chemin.
 *  - Le dernier composant du chemin est écrit en entier.
 *
 * Exemples:
 *
 *  - `path` = "/toto/est/content"   => "/t/e/content"
 *  - `path` = "~/toto/est/content"  => "~/t/e/content"
 *  - `path` = "~/toto/est/content/" => "~/t/e/content/"
 *  - `path` = "~/.toto/est/content" => "~/.t/e/content"
 */
void shorten_path(char * path);

/*****************************************************************************/

int main(int argc, char ** argv) {
  // Vérification des arguments
  if (argc != 2) {
    fprintf(stderr, "%s: FATAL: a unique argument (intended to be a path) must be provided.\n", *argv);
    return 1;
  }

  shorten_path(argv[1]);
  // Affichage
  printf("%s", argv[1]);
  return 0;
}

/*****************************************************************************/

void shorten_path(char * path) {
  int i, j, k;

  // Insertion de ~ si besoin
  if (path[0] == '~') {
    i = j = k = 1;
  } else {
    i = j = k = 0;
  }

  // Raccourcissement
  for (; path[i] != '\0'; i += 1) {
    // Si slash, début du raccourci
    if (path[i] == '/' && path[i + 1] != '\0') {
      // Le '/'
      path[j] = path[i];
      // Premier charactère du nom du dossier
      path[j + 1] = path[i + 1];
      // Si c'est un dossier caché (tel que .config), affiche .c au lieu de .
      // Les décalages de j et k sont fait en fonction de cet état
      if (path[i + 1] == '.' && path[i + 2] != '\0') {
        path[j + 2] = path[i + 2];
        j += 3;
        k = i + 3;
      } else {
        j += 2;
        k = i + 2;
      }
    }
  }

  // Complétion du dernier dossier
  for (; path[k] != '\0'; k += 1, j += 1) { path[j] = path[k]; }
  path[j] = '\0';
}
