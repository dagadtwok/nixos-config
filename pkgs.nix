{pkgs, ... }:
{
  programs.firefox.enable = true;
  programs.fish.enable = true;
  environment.systemPackages = with pkgs; [
    # Utils
    nixfmt
    wget
    git
    bc
    msr-tools
    fastfetch
    btop
    libsForQt5.qtstyleplugin-kvantum
    libsForQt5.qt5ct
    corectrl
    vscode

    # Media
    easyeffects
    qbittorrent
    spotify
    plexamp
    vesktop

    # Gaming
    steam
    bottles
    mangohud
    protontricks
  ];
}
