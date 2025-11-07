{ config, pkgs, ... }:

{
  # Bluetooth configuration
  hardware.bluetooth = {
    enable = true;
    package = pkgs.bluez5-experimental;
    powerOnBoot = true;
    settings.General.ControllerMode = "dual";
    settings.General.Enable = "Source,Sink,Media,Socket";
    settings.General.Experimental = "true";
    settings.General.FastConnectable = "true";
    settings.General.KernelExperimental = "true";
    settings.Policy.AutoEnable = "true";
  };
  services.blueman.enable = false;

  # Sound configuration with PipeWire
  services.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
  };

  # Printing support
  services.printing.enable = true;
}
