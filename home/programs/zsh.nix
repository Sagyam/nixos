{ config, pkgs, ... }:

{
  programs.zsh = {
    enable = true;
    enableCompletion = true;
    autosuggestion.enable = true;
    syntaxHighlighting.enable = true;

    shellAliases = {
      cat = "bat";
      dd = "duf";
      diff = "diff-so-fancy";
      dig = "dog";
      gc = "sudo nix-collect-garbage -d";
      grep = "rg";
      ls = "eza";
      ping = "gping";
      top = "btop";
      update = "sudo nixos-rebuild switch --flake /etc/nixos#nixos";
    };

    # Additional zsh configuration
    initContent = ''
      # Custom zsh configuration here
      eval "$(atuin init zsh)"
    '';
  };
}
