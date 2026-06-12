{ config, pkgs, inputs, ... }:

{
  # Home Manager needs to know about your user
  home.username = "sagyam";
  home.homeDirectory = "/home/sagyam";

  # Import modules
  imports = [
    ./packages.nix
    ./programs/default.nix
    ./services/vicinae.nix

    # Import Vicinae Home Manager module
    inputs.vicinae.homeManagerModules.default
  ];

  # Basic Home Manager settings
  home.stateVersion = "26.05";

  # Disable version mismatch warning (using unstable for both)
  home.enableNixpkgsReleaseCheck = false;

  # Let Home Manager manage itself
  programs.home-manager.enable = true;

  # Session variables
  home.sessionVariables = {
    EDITOR = "nvim";
  };
}
