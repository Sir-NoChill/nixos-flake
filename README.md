# Updating

- If you made edits to the system configuration, then run `sudo nixos-rebuild switch --flake .#hostname`
- If not, then you can just use `home-manager switch --flake .#username@hostname`
