{ pkgs, ... }: {
  environment.systemPackages = with pkgs; [
    audacity
    discord
    nodejs
    vivaldi
    tidal-hifi
    bitwarden-desktop

  ];
}
