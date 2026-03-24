{ config, pkgs, ... }:

{
  # Study Schedule Configuration (Single Source of Truth)
  studySchedule = {
    enable = true;
    windows = [
      # { name = "morning"; start = "9:00"; end = "11:00"; warnAt = "08:55"; }
      # { name = "afternoon"; start = "16:00"; end = "18:00"; warnAt = "15:55"; }
      # { name = "evening"; start = "19:05"; end = "22:00"; warnAt = "19:00"; }
    ];
  };

  # Enable Flakes support
  nix.settings.experimental-features = [ "nix-command" "flakes" ];


  # Cachix binary caches for Vicinae
  nix.settings = {
    substituters = [
      "https://cache.nixos.org"
      "https://vicinae.cachix.org"
    ];

    trusted-public-keys = [
      "vicinae.cachix.org-1:1kDrfienkGHPYbkpNj1mWTr7Fm1+zcenzgTizIcI3oc="
    ];
  };

  # Update system automatically
  system.autoUpgrade = {
    enable = true;
    allowReboot = false;
    flake = "path:/etc/nixos";
  };

  nixpkgs.config.allowUnfree = true;

  # Enable flatpak support
  services.flatpak.enable = true;

  # Enable garbage collection
  nix.gc = {
    automatic = true;
    dates = "daily";
    options = "--delete-older-than 7d";
  };

  # Version of the NixOS system
  system.stateVersion = "25.11";
}
