with rec {
  emacs-overlay = import (builtins.fetchTarball { url = https://github.com/nix-community/emacs-overlay/archive/master.tar.gz; });
  pkgs = import <nixpkgs> { overlays = [ emacs-overlay ]; };
};

rec {
  emacs-head = pkgs.emacsGcc.overrideAttrs ( old: {
    configureFlags = old.configureFlags ++ [ 
      "--with-json"  
      "--with-cairo"
      "--without-compress-install"
      "--with-x-toolkit=no"
      "--with-gnutls"
      "--without-gconf"
      "--without-xwidgets"
      "--without-toolkit-scroll-bars"
      "--without-xaw3d"
      "--without-gsettings"
      "--with-mailutils"
      "--with-harfbuzz"
      #"--with-imagemagick"
      "--with-jpeg"
      "--with-png"
      "--with-rsvg"
      "--with-tiff"
      "--with-wide-int"
      "--with-xft"
      "--with-xml2"
      "--with-x-toolkit=lucid"
    ];
  });
  emacs-head-nox = emacs-head.override {
    withX = false;
    withGTK2 = false;
    withGTK3 = false;
  };
}
