{ pkgs, ... }: {
  environment.systemPackages = with pkgs; [
    audacity 
    discord
    nodejs
    vivaldi #browser
    tidal-hifi #musik
    bitwarden-desktop #password-manager
    kdePackages.qtmultimedia 
    quickshell
    google-chrome
    insync #google drive sync

    firefox
  ];
}

