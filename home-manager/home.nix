{
  inputs,
  outputs,
  lib,
  config,
  pkgs,
  xdg,
  ...
}: {
  # You can import other home-manager modules here
  imports = [
    # If you want to use modules your own flake exports (from modules/home-manager):
    # outputs.homeManagerModules.emacs

    # Or modules exported from other flakes (such as nix-colors):
    # inputs.nix-colors.homeManagerModules.default

    # You can also split up your configuration and import pieces of it here:
    # ./nvim.nix
    # ./emacs.nix
    # ./git.nix
    # ./emacs.nix
    ./zsh.nix
  ];

  nixpkgs = {
    # You can add overlays here
    overlays = [
      # Add overlays your own flake exports (from overlays and pkgs dir):
      outputs.overlays.additions
      outputs.overlays.modifications
      outputs.overlays.unstable-packages
      # outputs.overlays.emacs-head

      # You can also add overlays exported from other flakes:
      # neovim-nightly-overlay.overlays.default

      # Or define it inline, for example:
      # (final: prev: {
      #   hi = final.hello.overrideAttrs (oldAttrs: {
      #     patches = [ ./change-hello-to-hi.patch ];
      #   });
      # })
    ];
    # Configure your nixpkgs instance
    config = {
      # Disable if you don't want unfree packages
      allowUnfree = true;

      # packageOverrides = pkgs: {
      #   custom-emacs = (pkgs.emacs.override { 
      #     imagemagick = pkgs.imagemagickBig;
      #     withNativeCompilation = true;
      #   }).overrideAttrs (old : {
      #     pname = "emacs";
      #     version = "28.";
      #     src = pkgs.fetchFromGitHub {
      #       owner = "emacs-mirror";
      #       repo = "emacs";
      #       rev = "739b5d0e52d83ec567bd61a5a49ac0e93e0eb469";
      #       hash = "sha256-4oSLcUDR0MOEt53QOiZSVU8kPJ67GwugmBxdX3F15Ag=";
      #     };
      #     patches = [];
      #     configureFlags = [
      #       "--with-json"
      #       "--with-cairo"
      #       "--without-compress-install"
      #       "--with-x-toolkit=no"
      #       "--with-gnutls"
      #       "--without-gconf"
      #       "--without-xwidgets"
      #       "--without-toolkit-scroll-bars"
      #       "--without-xaw3d"
      #       "--without-gsettings"
      #       "--with-mailutils"
      #       "--with-harfbuzz"
      #       # FIXME need to figure out why this won't work
      #       # "--with-imagemagick"
      #       "--with-jpeg"
      #       "--with-png"
      #       "--with-rsvg"
      #       "--with-tiff"
      #       "--with-wide-int"
      #       "--with-xft"
      #       "--with-xml2"
      #       "--with-x-toolkit=lucid"
      #     ];
      #     preConfigure = "./autogen.sh";
      #     # buildInputs = old.buildInputs ++ [ autoconf texinfo ];
      #   });
      # };
    };
  };

  # Set username
  home = {
    username = "stormblessed";
    homeDirectory = "/home/stormblessed";
  };

  # Add stuff for your user as you see fit:
  programs.neovim.enable = true;
  programs.neovim.defaultEditor = true;
  home.packages = with pkgs; [ 
    tmux  # terminal multiplexer
    pdftk  # pdf utils
    alacritty  # the alacritty terminal
    oh-my-zsh  # for shell configs
    thunderbird  # email
    # custom-emacs  # the real os
    localsend  # airdrop
    openssh
    cloudflared
    zotero_7
    nerdfonts
    picom
    feh
  ];

  home.sessionVariables = {
    TERMINAL = "alacritty";
  };

  # Enable home-manager and git
  programs.home-manager.enable = true;
  programs.git = {
    enable = true;

    # Configure git settings
    # FIXME this should be a secret
    userName = "Ayrton Chilibeck";
    userEmail = "code@blobfish.icu";
  };

  # setup leftwm
  xdg.configFile."leftwm/config.ron".source = ./leftwm.ron;
  xdg.configFile."leftwm/themes/current".source = pkgs.fetchFromGitHub {
    owner = "Sir-NoChill";
    repo = "ocean-night";
    rev = "master";
    sha256 = "sha256-gFvoUOBQxANSL3yX5mIK6Xc7g8obZT9OmYUImo3kyXM=";
  };

  # Nicely reload system units when changing configs
  systemd.user.startServices = "sd-switch";

  # https://nixos.wiki/wiki/FAQ/When_do_I_update_stateVersion
  home.stateVersion = "23.05";
}
