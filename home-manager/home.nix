# This is your home-manager configuration file
# Use this to configure your home environment (it replaces ~/.config/nixpkgs/home.nix)
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
    zotero
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

  # Nicely reload system units when changing configs
  systemd.user.startServices = "sd-switch";

  # https://nixos.wiki/wiki/FAQ/When_do_I_update_stateVersion
  home.stateVersion = "23.05";
}
