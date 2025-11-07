{ config, pkgs, ... }:

{
  # Docker configuration
  virtualisation.docker.enable = true;
  virtualisation.docker.rootless = {
    enable = true;
    setSocketVariable = true;
  };

  # VirtualBox configuration
  virtualisation.virtualbox.guest.clipboard = false;
  virtualisation.virtualbox.guest.dragAndDrop = false;
  virtualisation.virtualbox.guest.enable = false;
  virtualisation.virtualbox.guest.seamless = false;
  virtualisation.virtualbox.host.addNetworkInterface = false;
  virtualisation.virtualbox.host.enable = false;
  virtualisation.virtualbox.host.enableExtensionPack = false;
  virtualisation.virtualbox.host.enableKvm = false;
}
