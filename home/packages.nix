{ config, pkgs, ... }:

{
  home.packages = with pkgs; [
    # Browser
    ungoogled-chromium
    firefox
    tor-browser

    # Development tools
    aria2
    atuin
    azure-cli
    bandwhich
    bat
    btop
    cargo
    curl
    diff-so-fancy
    doggo
    dua
    duf
    eza
    fastfetch
    ffmpeg
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
    dmidecode
    pciutils

    # GNOME applications
    authenticator
    ente-auth
    fragments
    gnome-decoder
    mission-center
    papers
    share-preview
    switcheroo
    textpieces
    varia

    # GNOME extensions
    gnomeExtensions.internet-speed-meter
    gnomeExtensions.bluetooth-battery-meter
    gnomeExtensions.clipboard-indicator
    gnomeExtensions.tiling-shell
    gnomeExtensions.wallpaper-slideshow

    # Fonts
    intel-one-mono
    nerd-fonts.sauce-code-pro
    nerd-fonts.symbols-only

    # Development environments
    jetbrains-toolbox

    # Node.js ecosystem
    bun
    nodejs_24

    # Kubernetes tools
    k9s
    kubernetes
    kustomize
    minikube
    terraform

    # Container tools
    docker
    lazydocker
    qemu

    # Media
    audiobookshelf
    vlc
    warp

    # Utilities
    nerdfetch
    sql-studio
    systemctl-tui
  ];
}
