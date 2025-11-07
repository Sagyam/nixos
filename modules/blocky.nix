{ config, pkgs, ... }:
let
  # --- Use shared study schedule configuration ---
  blockWindows = config.studySchedule.windows;

  # --- Blocklist Configuration ---
  socialBlocklist = pkgs.writeText "social-blocklist.txt" ''
    reddit.com
    www.reddit.com
    old.reddit.com
    youtube.com
    www.youtube.com
    m.youtube.com
    youtu.be
    twitter.com
    www.twitter.com
    mobile.twitter.com
    x.com
    www.x.com
    facebook.com
    www.facebook.com
    m.facebook.com
    instagram.com
    www.instagram.com
    tiktok.com
    www.tiktok.com
    vm.tiktok.com
    netflix.com
    www.netflix.com
    daraz.com.np
    www.daraz.com.np
    amazon.com
    www.amazon.com
    amazon.in
    www.amazon.in

  '';

  # --- Helper Scripts ---

  enableBlockyScript = pkgs.writeShellScript "enable-blocky.sh" ''
    set -e
    ${pkgs.systemd}/bin/systemctl start blocky.service
    # Wait for Blocky to be ready
    sleep 2
    ${pkgs.systemd}/bin/systemctl restart systemd-resolved
  '';

  disableBlockyScript = pkgs.writeShellScript "disable-blocky.sh" ''
    set -e
    ${pkgs.systemd}/bin/systemctl stop blocky.service
    ${pkgs.systemd}/bin/systemctl restart systemd-resolved
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
  ## ─────────────────────────────────────────────
  ## Enable systemd-resolved for DNS fallback
  ## ─────────────────────────────────────────────
  services.resolved = {
    enable = true;
    # Use Blocky when available, fall back to Cloudflare
    fallbackDns = [ "1.1.1.1" "1.0.0.1" ];
    extraConfig = ''
      DNSStubListener=no
    '';
  };

  ## ─────────────────────────────────────────────
  ## Blocky DNS Service
  ## ─────────────────────────────────────────────
  services.blocky = {
    enable = true;
    settings = {
      ports.dns = 53;
      upstreams.groups.default = [
        "https://one.one.one.one/dns-query"
      ];

      bootstrapDns = {
        upstream = "https://one.one.one.one/dns-query";
        ips = [ "1.1.1.1" "1.0.0.1" ];
      };

      blocking = {
        blackLists = {
          social = [
            "file://${socialBlocklist}"
          ];
        };
        clientGroupsBlock = {
          default = [ "social" ];
        };
        blockType = "zeroIp";
        blockTTL = "1m";
      };

      queryLog = {
        type = "console";
      };
    };
  };

  ## ─────────────────────────────────────────────
  ## DNS Configuration with Fallback
  ## ─────────────────────────────────────────────
  networking.nameservers = [ "127.0.0.1" "1.1.1.1" "1.0.0.1" ];

  ## ─────────────────────────────────────────────
  ## Create all services dynamically
  ## ─────────────────────────────────────────────
  systemd.services = builtins.listToAttrs (
    builtins.concatMap (window: [
      {
        name = "blocky-enable-${window.name}";
        value = mkService
          "blocky-enable-${window.name}"
          "Enable Blocky DNS blocking at ${window.start} (${window.name})"
          enableBlockyScript;
      }
      {
        name = "blocky-disable-${window.name}";
        value = mkService
          "blocky-disable-${window.name}"
          "Disable Blocky DNS blocking at ${window.end} (${window.name})"
          disableBlockyScript;
      }
    ]) blockWindows
  ) // {
    # Prevent Blocky from starting at boot
    blocky.wantedBy = pkgs.lib.mkForce [];
  };

  ## ─────────────────────────────────────────────
  ## Create all timers dynamically
  ## ─────────────────────────────────────────────
  systemd.timers = builtins.listToAttrs (
    builtins.concatMap (window: [
      {
        name = "blocky-enable-${window.name}";
        value = mkTimer window.start;
      }
      {
        name = "blocky-disable-${window.name}";
        value = mkTimer window.end;
      }
    ]) blockWindows
  );
}