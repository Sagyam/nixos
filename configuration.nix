{ config, pkgs, ... }:

{
  # Study Schedule Configuration (Single Source of Truth)
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

  # Allow unfree packages and insecure packages
  nixpkgs.config = {
    allowUnfree = true;
    permittedInsecurePackages = [
      # "qtwebengine-5.15.19"
    ];
  };

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
