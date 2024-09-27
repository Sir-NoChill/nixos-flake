# This file defines overlays
{inputs, ...}: {
  # This one brings our custom packages from the 'pkgs' directory
  additions = final: _prev: import ../pkgs final.pkgs;

  # This one contains whatever you want to overlay
  # You can change versions, add patches, set compilation flags, anything really.
  # https://nixos.wiki/wiki/Overlays
  modifications = final: prev: {
    # example = prev.example.overrideAttrs (oldAttrs: rec {
    # ...
    # });
  };

  # When applied, the unstable nixpkgs set (declared in the flake inputs) will
  # be accessible through 'pkgs.unstable'
  unstable-packages = final: _prev: {
    unstable = import inputs.nixpkgs-unstable {
      system = final.system;
      config.allowUnfree = true;
    };
  };

  # # Overlay for emacs
  # emacs-head = pkgs.emacsGcc.overrideAttrs ( old: {
  #   configureFlags = old.configureFlags ++ [ 
  #     "--with-json"  
  #     "--with-cairo"
  #     "--without-compress-install"
  #     "--with-x-toolkit=no"
  #     "--with-gnutls"
  #     "--without-gconf"
  #     "--without-xwidgets"
  #     "--without-toolkit-scroll-bars"
  #     "--without-xaw3d"
  #     "--without-gsettings"
  #     "--with-mailutils"
  #     "--with-harfbuzz"
  #     #"--with-imagemagick"
  #     "--with-jpeg"
  #     "--with-png"
  #     "--with-rsvg"
  #     "--with-tiff"
  #     "--with-wide-int"
  #     "--with-xft"
  #     "--with-xml2"
  #     "--with-x-toolkit=lucid"
  #   ];
  # });
  # emacs-head-nox = emacs-head.override {
  #   withX = false;
  #   withGTK2 = false;
  #   withGTK3 = false;
  # };
  
}
