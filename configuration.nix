{ config, pkgs, ... }:

{
  imports = [
    ./hardware-configuration.nix
    ./modules/blocky.nix
    ./modules/boot.nix
    ./modules/desktop.nix
    ./modules/hardware.nix
    ./modules/networking.nix
    ./modules/packages.nix
    ./modules/programs.nix
    ./modules/services.nix
    ./modules/study-lock.nix
    ./modules/study-schedule.nix
    ./modules/users.nix
    ./modules/virtualisation.nix
  ];

  # --- Study Schedule Configuration (Single Source of Truth) ---
  studySchedule = {
    enable = true;
    windows = [
      # { name = "morning"; start = "10:00"; end = "11:30"; warnAt = "09:55"; }
      # { name = "afternoon"; start = "14:00"; end = "16:00"; warnAt = "13:55"; }
      # { name = "evening"; start = "19:00"; end = "21:00"; warnAt = "18:55"; }
    ];
  };

  # Enable Flakes support
  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  # Update system automatically
  system.autoUpgrade.enable = true;
  system.autoUpgrade.allowReboot = false;

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;
  nixpkgs.config.permittedInsecurePackages = [
    "qtwebengine-5.15.19"
  ];

  # Enable flatpak support
  services.flatpak.enable = true;

  # Configure GRUB theme
  distro-grub-themes = {
    enable = true;
    theme = "nixos";  # Options: arch, debian, fedora, kali, manjaro, nixos, pop, ubuntu, windows
  };


  # Enable garbage collection
  nix.gc = {
    automatic = true;
    dates = "daily";
    options = "--delete-older-than 7d";
  };

  # Version of the NixOS system
  system.stateVersion = "25.05";
}
