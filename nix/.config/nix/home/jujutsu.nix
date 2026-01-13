{ pkgs, pkgs-unstable, ... }:
let
  unstable = pkgs-unstable;
in
{
  programs.jujutsu = {
    enable = true;
    package = unstable.jujutsu;
    settings = {
      user = {
        name = "aidan";
        email = "aidanaden@hotmail.com";
      };

      aliases = {
        tug = [
          "bookmark"
          "move"
          "--from"
          "heads(::@- & bookmarks())"
          "--to"
          "@"
        ];

        "tug-" = [
          "bookmark"
          "move"
          "--from"
          "heads(::@- & bookmarks())"
          "--to"
          "@-"
        ];

        "rebase-all" = [
          "rebase"
          "-s"
          "all:roots(trunk()..mutable())"
          "-d"
          "trunk()"
        ];

        # Take content from any change, and move it into @.
        # - jj consume xyz path/to/file`
        consume = [
          "squash"
          "--into"
          "@"
          "--from"
        ];

        # Eject content from @ into any other change.
        # - jj eject xyz --interactive
        eject = [
          "squash"
          "--from"
          "@"
          "--into"
        ];
      };

      revsets = {
        # By default, show the current stack of work.
        # log = "stack(@)";
      };

      revset-aliases = {
        # trunk() by default resolves to the latest 'main'/'master' remote bookmark. May
        # require customization for repos like nixpkgs.
        "trunk()" = "latest((present(main) | present(master)) & remote_bookmarks())";

        # stack(x, n) is the set of mutable commits reachable from 'x', with 'n'
        # parents. 'n' is often useful to customize the display and return set for
        # certain operations. 'x' can be used to target the set of 'roots' to traverse,
        # e.g. @ is the current stack.
        "stack()" = "ancestors(reachable(@, mutable()), 2)";
        "stack(x)" = "ancestors(reachable(x, mutable()), 2)";
        "stack(x, n)" = "ancestors(reachable(x, mutable()), n)";
      };

      snapshot = {
        "auto-update-stale" = true;
      };

      ui = {
        "diff-formatter" = [
          "difft"
          "--color=always"
          "$left"
          "$right"
        ];
      };
    };
  };
}
