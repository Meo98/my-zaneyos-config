{ ... }: {
  imports = [
    ./hardware.nix
    ./host-packages.nix
  ];

  programs.kdeconnect.enable = true;

  # Vivaldi als Standard-Browser erzwingen
  xdg.mime.defaultApplications = {
    "text/html" = "vivaldi-stable.desktop";
    "x-scheme-handler/http" = "vivaldi-stable.desktop";
    "x-scheme-handler/https" = "vivaldi-stable.desktop";
    "x-scheme-handler/about" = "vivaldi-stable.desktop";
    "x-scheme-handler/unknown" = "vivaldi-stable.desktop";
  };
}
