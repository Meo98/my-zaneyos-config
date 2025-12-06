{ pkgs, ... }: {
  environment.systemPackages = with pkgs; [
    audacity 
    discord
    nodejs
    vivaldi #browser
    tidal-hifi #musik
    bitwarden-desktop #password-manager
    kdePackages.qtmultimedia 
    google-chrome
    insync #google drive sync
    antigravity #google ide

    firefox
  ];
}

