{ config, pkgs, ... }:

{
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  # Reduce bootloader timeout so Plymouth shows faster
  boot.loader.timeout = 1;

  boot.plymouth = {
    enable = true;
    themePackages = [ pkgs.nixos-bgrt-plymouth ];
    theme = "nixos-bgrt";
    extraConfig = ''
      [Daemon]
      Theme=nixos-bgrt
      ShowDelay=0
      DeviceTimeout=3
    '';
  };

  # Enable Plymouth in initrd (required for boot-time display)
  boot.initrd.systemd.enable = true;

  # Load KMS driver early for proper graphics during boot
  boot.initrd.kernelModules = [ "amdgpu" ];

  # Ensure video driver loads as early as possible
  boot.kernelModules = [ "amdgpu" ];

  boot.consoleLogLevel = 0;
  boot.kernelParams = [
    "quiet"
    "splash"
    "boot.shell_on_fail"
    "loglevel=3"
    "rd.systemd.show_status=false"
    "rd.udev.log_level=3"
    "udev.log_priority=3"
    "vt.global_cursor_default=0"
    "plymouth.ignore-serial-consoles"
    "video=efifb:off"  # Disable EFI framebuffer to let KMS take over
  ];
}