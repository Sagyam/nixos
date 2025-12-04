{ config, pkgs, ... }:

{
  home.packages = with pkgs; [
    # Development tools
    aria2
    atuin
    azure-cli
    bandwhich
    bat
    brave
    btop
    cargo
    curl
    diff-so-fancy
    docker
    dogdns
    dua
    duf
    eza
    fastfetch
    firefox
    fzf
    gcc
    gh
    ghostty
    git
    gnumake
    gnupg
    gping
    hey
    httpie
    jq
    lazydocker
    lazygit
    lazyjournal
    neovim
    ripgrep
    rustc
    tldr
    tokei
    vscode
    yq
    yt-dlp
    zsh

    # System utilities
    ddcutil
    dmidecode
    pciutils

    # GNOME applications
    authenticator
    ente-auth
    fragments
    gnome-decoder
    gnome-graphs
    mission-center
    papers
    share-preview
    switcheroo
    textpieces
    varia

    # GNOME extensions
    gnomeExtensions.speed-buzz-internet-speed-meter
    gnomeExtensions.bluetooth-battery-meter
    gnomeExtensions.clipboard-indicator
    gnomeExtensions.tiling-shell
    gnomeExtensions.wallpaper-slideshow

    # Fonts
    intel-one-mono
    nerd-fonts.sauce-code-pro
    nerd-fonts.symbols-only

    # Development environments
    jetbrains.goland
    jetbrains.rust-rover
    jetbrains.webstorm

    # Node.js ecosystem
    nodejs_24
    pnpm
    bun
    deno

    # Kubernetes tools
    k9s
    kubernetes
    kustomize
    minikube
    terraform

    # Container tools
    qemu

    # Gaming
    winetricks
    wineWowPackages.full
    protontricks
    fuse-overlayfs
    bubblewrap
    dwarfs

    # Media
    audiobookshelf
    vlc
    warp

    # Utilities
    nerdfetch
    reddit-tui
    sql-studio
    systemctl-tui
    tor-browser

    # Experimental
    gemini-cli
    antigravity
    claude-code
    claude-monitor
  ];
}
