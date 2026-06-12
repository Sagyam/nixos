{ config, pkgs, ... }:

{
  # System-wide programs that need system integration

  # Firefox (system-wide)
  programs.firefox.enable = true;

  # Zsh (must be enabled system-wide for user shells)
  programs.zsh.enable = true;

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

  # Enable 32-bit support for graphics (Required for Wine/Proton)
  hardware.graphics = {
    enable = true;
    enable32Bit = true; 
  };

  # Steam (requires system integration for graphics drivers)
  programs.steam = {
    enable = true;
    remotePlay.openFirewall = true;
    dedicatedServer.openFirewall = true;
    localNetworkGameTransfers.openFirewall = true;
  };

  # System-wide packages (truly global)
  environment.systemPackages = with pkgs; [
    sudo
    vim
    git
  ];
}
