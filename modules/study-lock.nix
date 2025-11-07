{ config, pkgs, ... }:
let
  # --- Use shared study schedule configuration ---
  lockWindows = config.studySchedule.windows;

  USER = "sagyam";
  NOTIFICATION_DELAY = "300"; # 5 minutes in seconds

  # --- Helper Scripts ---
  
  isInLockWindowScript = pkgs.writeShellScript "is-in-lock-window.sh" ''
    set -e
    current_hour=$(date +%H)
    current_minute=$(date +%M)
    current_time=$((current_hour * 60 + current_minute))
    
    # Convert time strings to minutes
    time_to_minutes() {
      local time=$1
      local hour=''${time%%:*}
      local minute=''${time##*:}
      echo $((10#$hour * 60 + 10#$minute))
    }
    
    # Check each lock window
    ${builtins.concatStringsSep "\n" (map (window: ''
      start_time=$(time_to_minutes "${window.start}")
      end_time=$(time_to_minutes "${window.end}")
      if (( current_time >= start_time && current_time < end_time )); then
        exit 0  # Inside lock window
      fi
    '') lockWindows)}
    
    exit 1  # Outside all lock windows
  '';

  sendWarningScript = pkgs.writeShellScript "send-warning.sh" ''
    set -e
    USER="${USER}"
    uid=$(id -u "$USER")
    
    if ${pkgs.systemd}/bin/loginctl show-user "$USER" >/dev/null 2>&1; then
      ${pkgs.sudo}/bin/sudo -u "$USER" \
        DISPLAY=:0 \
        DBUS_SESSION_BUS_ADDRESS=unix:path=/run/user/$uid/bus \
        ${pkgs.libnotify}/bin/notify-send "Study Time" \
          "Your session will end in 5 minutes. Save your work."
    fi
  '';

  lockScript = pkgs.writeShellScript "lock-sagyam.sh" ''
    set -e
    USER="${USER}"
    
    # Only lock if we're in a lock window
    if ${isInLockWindowScript}; then
      ${pkgs.systemd}/bin/loginctl terminate-user "$USER" || true
      ${pkgs.shadow}/bin/usermod -L "$USER"
    fi
  '';

  unlockScript = pkgs.writeShellScript "unlock-sagyam.sh" ''
    set -e
    USER="${USER}"
    ${pkgs.shadow}/bin/usermod -U "$USER"
  '';

  # --- Helper function to create service config ---
  mkService = name: description: script: {
    inherit description;
    serviceConfig = {
      Type = "oneshot";
      ExecStart = [ script ];
    };
  };

  # --- Helper function to create timer config ---
  mkTimer = time: {
    wantedBy = [ "timers.target" ];
    timerConfig = {
      OnCalendar = time;
      Persistent = true;
    };
  };

in
{
  # --- Study User Configuration ---
  users.users.study = {
    isNormalUser = true;
    description = "Study account";
    extraGroups = [ "networkmanager" ];
    password = "3301";
    packages = with pkgs; [
      firefox
      vscode
    ];
  };

  # --- Create all services ---
  systemd.services = builtins.listToAttrs (
    builtins.concatMap (window: [
      {
        name = "warn-${window.name}";
        value = mkService 
          "warn-${window.name}"
          "Send warning before ${window.name} lock"
          sendWarningScript;
      }
      {
        name = "lock-${window.name}";
        value = mkService 
          "lock-${window.name}"
          "Lock sagyam at ${window.start} (${window.name})"
          lockScript;
      }
      {
        name = "unlock-${window.name}";
        value = mkService 
          "unlock-${window.name}"
          "Unlock sagyam at ${window.end} (${window.name})"
          unlockScript;
      }
    ]) lockWindows
  );

  # --- Create all timers ---
  systemd.timers = builtins.listToAttrs (
    builtins.concatMap (window: [
      {
        name = "warn-${window.name}";
        value = mkTimer window.warnAt;
      }
      {
        name = "lock-${window.name}";
        value = mkTimer window.start;
      }
      {
        name = "unlock-${window.name}";
        value = mkTimer window.end;
      }
    ]) lockWindows
  );

  # --- Sudo Configuration ---
  security.sudo.enable = true;
  security.sudo.extraRules = [
    {
      users = [ "sagyam" ];
      commands = [ { command = "ALL"; options = [ "NOPASSWD" ]; } ];
    }
  ];
}