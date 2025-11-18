{ config, pkgs, ... }:

{
  # Firefox
  programs.firefox.enable = true;

  # Starship prompt
  programs.starship = {
    enable = true;
  };

  # Zsh configuration
  programs.zsh = {
    autosuggestions.enable = true;
    enable = true;
    enableCompletion = true;
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
      update = "sudo nixos-rebuild switch";
    };
  };

  # MTR program
  programs.mtr.enable = true;

  # Gaming
  programs.gamemode.enable = true;

  # DLL Support
  programs.nix-ld.enable = true;

  # GPG agent
  programs.gnupg.agent = {
    enable = true;
    enableSSHSupport = true;
  };

  # Steam
  programs.steam = {
    enable = true;
    remotePlay.openFirewall = true;
    dedicatedServer.openFirewall = true;
    localNetworkGameTransfers.openFirewall = true;
  };
}