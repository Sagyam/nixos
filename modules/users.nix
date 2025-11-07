{ config, pkgs, ... }:

{
  # User configuration
  users.users.sagyam = {
    isNormalUser = true;
    description = "sagyam";
    extraGroups = [ "networkmanager" "wheel" "docker" ];
    packages = with pkgs; [];
  };
  users.defaultUserShell = pkgs.zsh;

  # VirtualBox user group
  users.extraGroups.vboxusers.members = [ "sagyam" ];
}
