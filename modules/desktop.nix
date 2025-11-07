{ config, pkgs, ... }:

{
  # Locale and timezone
  time.timeZone = "Asia/Kathmandu";
  i18n.defaultLocale = "en_US.UTF-8";

  # X11 and GNOME desktop
  services.xserver.enable = true;
  services.xserver.displayManager.gdm = {
    enable = true;
    wayland = true;
  };

  services.xserver.desktopManager.gnome.enable = true;

  # Ensure GDM waits for Plymouth to finish
  systemd.services.display-manager.wants = [ "plymouth-quit.service" ];
  systemd.services.display-manager.after = [ "plymouth-quit.service" "plymouth-start.service" "systemd-user-sessions.service" ];

  # Disable GDM's initial setup screen which can interfere with Plymouth
  services.gnome.gnome-initial-setup.enable = false;

  # Keymap configuration
  services.xserver.xkb = {
    layout = "us";
    variant = "";
  };
}
