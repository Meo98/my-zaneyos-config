{ pkgs, inputs, ... }: {

  services.flatpak.enable = true;

  environment.systemPackages = with pkgs; [
    audacity
    discord
    nodejs
    vivaldi
    tidal-hifi
    bitwarden-desktop
    kdePackages.qtmultimedia
    google-chrome
    insync
    antigravity
    distrobox
    kicad
    vlc
    onlyoffice-desktopeditors

    vulkan-tools
    mesa-demos # für glxinfo, optional
    gamescope

    qmk # keyboard tool
    vial # keyboard tool
    dos2unix

    # optional v2:
    # inputs.affinity-nix.packages.${pkgs.system}.designer
    # inputs.affinity-nix.packages.${pkgs.system}.photo
    # inputs.affinity-nix.packages.${pkgs.system}.publisher

    (makeDesktopItem {
      name = "ms-office-365";
      desktopName = "Microsoft 365";
      exec = "${pkgs.vivaldi}/bin/vivaldi --app=\"https://www.office.com/?auth=2\"";
      icon = "vivaldi";
      categories = [ "Office" ];
    })

    firefox
  ];
}
