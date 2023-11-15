# To ensure this nix-shell is reproducible, we pin the packages index to a commit SHA taken from a channel on https://status.nixos.org/
# This commit is from nixpkgs-unstable, it's somewhere between NixOS 23.05 and the following version
with (import (fetchTarball https://github.com/NixOS/nixpkgs/archive/b5f8ec6be261dfc44c3b56b220e2793d1b61512b.tar.gz) {});

mkShell {
  buildInputs = [
    ruby_3_2
    # Locales
    glibcLocales
    # Install certificates to prevent SSL errors
    cacert
    # Packages for native extensions for some Ruby gems, as noted in comments
    libyaml # psych
    # CHANGEME: Uncomment this package if you develop applications with SQLite, otherwise delete this.
    # Database SQLite
    # sqlite
  ];

  shellHook = ''
    # Set LANG for locales, otherwise it is unset when running "nix-shell --pure"
    export LANG="C.UTF-8"

    # Remove duplicate commands from Bash shell command history
    export HISTCONTROL=ignoreboth:erasedups

    # Keep Bundler data in the project (Be sure to ignore this directory in `.gitignore`)
    export BUNDLE_PATH="$PWD/.bundle"
    mkdir -p "$BUNDLE_PATH"
  '';

  # Without this, there are warnings about LANG, LC_ALL and locales.
  # Many tests fail due those warnings showing up in test outputs too...
  # This solution is from: https://gist.github.com/aabs/fba5cd1a8038fb84a46909250d34a5c1
  LOCALE_ARCHIVE = "${glibcLocales}/lib/locale/locale-archive";
}
