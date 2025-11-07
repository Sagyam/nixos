{ config, pkgs, ... }:

{
  # GPG smart card daemon
  services.pcscd.enable = true;
}
