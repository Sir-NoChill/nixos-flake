{
  programs,
  config,
  ...
}: {
  programs.zsh = {
    enable = true;
    enableCompletion = true;
    syntaxHighlighting.enable = true;

    shellAliases = {
      vim = "nvim";
      ll = "ls -l";
      update = "home-manager switch -b backup --flake .#stormblessed@kaladin --extra-experimental-features nix-command --extra-experimental-features flakes";
    };

    oh-my-zsh = {
      enable = true;
      theme = "nanotech";
      plugins = [
        "git"
	"sudo"
      ];
    };

    history = {
      size = 10000;
      path = "${config.xdg.dataHome}/zsh/history";
    };

    initExtra = ''
      path+="$HOME/.config/emacs/bin"
    '';
  };
}
