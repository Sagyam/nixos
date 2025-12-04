{ config, pkgs, ... }:

{
  # Packages for sagyam user
   users.users.sagyam = {
   packages = with pkgs; [
    aria2
    atuin
    audiobookshelf
    authenticator
    azure-cli
    bandwhich
    bat
    brave
    btop
    cargo
    curl
    ddcutil
    diff-so-fancy
    dmidecode
    docker
    dogdns
    dua
    duf
    ente-auth
    errands
    eza
    fastfetch
    firefox
    fragments
    fzf
    gcc
    gh
    ghostty
    git
    gnome-decoder
    gnome-graphs
    gnomeExtensions.speed-buzz-internet-speed-meter
    gnomeExtensions.bluetooth-battery-meter
    gnomeExtensions.clipboard-indicator
    gnomeExtensions.tiling-shell
    gnomeExtensions.wallpaper-slideshow
    gnumake
    gnupg
    gping
    hey
    httpie
    intel-one-mono
    iotas
    jetbrains.goland
    jetbrains.rust-rover
    jetbrains.webstorm
    jq
    k9s
    kubernetes
    kustomize
    lazydocker
    lazygit
    lazyjournal
    minikube
    mission-center
    neovim
    nerd-fonts.sauce-code-pro
    nerd-fonts.symbols-only
    nerdfetch
    papers
    pciutils
    qemu
    reddit-tui
    ripgrep
    rustc
    share-preview
    stremio
    switcheroo
    systemctl-tui
    terraform
    textpieces
    tldr
    tokei
    tor-browser
    varia
    vlc
    vscode
    warp
    yq
    yt-dlp
    zsh

    # Nodejs and pnpm
    nodejs_24
    pnpm
    bun
    deno

    # Gaming related packages
    winetricks
    wineWowPackages.full
    protontricks

    # Mini metro related packages
    fuse-overlayfs
    bubblewrap
    dwarfs

    # Experimental
    gemini-cli
    antigravity
    claude-code
    claude-monitor
  ];
  };

  # Universal packages
  environment.systemPackages = with pkgs; [
    bat
    dogdns
    fzf
    gnomeExtensions.bluetooth-battery-meter
    gnomeExtensions.clipboard-indicator
    gnomeExtensions.tiling-shell
    gnomeExtensions.wallpaper-slideshow
    gping
    httpie
    jq
    lazydocker
    lazygit
    lazyjournal
    ripgrep
    rustc
    starship
    sudo
    tldr
    vlc
  ];
}
