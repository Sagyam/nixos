{ config, pkgs, ... }:

{
  # Networking configuration
  systemd.services.NetworkManager-wait-online.enable = false;
  networking.hostName = "nixos";
  networking.networkmanager.enable = true;
  networking.extraHosts = "";

  # Firewall configuration
  networking.firewall.allowedTCPPorts = [];
  networking.firewall.allowedUDPPorts = [];

  # Tailscale
  services.tailscale.enable = true;
}
