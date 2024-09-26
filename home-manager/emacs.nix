# https://www.heinrichhartmann.com/posts/2021-08-08-nix-emacs/
{
  home,
  pkgs,
  fetchFromGitHub,
  ...
}:
{
  home.programs = home.programs ++ [(pkgs.emacs.override {
    withNativeCompilation = true;
  }).overrideAttrs (old : {
    pname = "emacs";
    version = "head";
    src = fetchFromGitHub {
      owner = "emacs-mirror";
      repo = "emacs";
      rev = "4d439744685b6b2492685124994120ebd1fa4abb";
      sha256 = "00vxb83571r39r0dbzkr9agjfmqs929lhq9rwf8akvqghc412apf";
    };
    patches = [];
    configureFlags = [
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
    preConfigure = "./autogen.sh";
    # buildInputs = old.buildInputs ++ [ autoconf texinfo ];
  })];
}
