{ pkgs, inputs, ... }: {

  services.flatpak.enable = true; # Ermöglicht die Installation von Flatpaks (GUI-Apps außerhalb des Nix-Stores)

  environment.systemPackages = with pkgs; [
    # --- Multimedia & Kommunikation ---
    audacity                  # Open-Source Audio-Editor für Aufnahme und Bearbeitung
    discord                   # Chat- und Voice-Plattform für Communities/Gaming
    vlc                       # Universeller Medienplayer, spielt fast jedes Videoformat ab
    tidal-hifi                # Desktop-Client für den High-Fidelity Musik-Streamingdienst Tidal

    # --- Webbrowser ---
    vivaldi                   # Feature-reicher Browser mit Fokus auf Tab-Management und Privatsphäre
    google-chrome             # Standard-Browser von Google (oft nötig für DRM/Netflix-Stabilität)
    firefox                   # Der klassische, privatsphäre-orientierte Open-Source Browser

    # --- Produktivität & Office ---
    bitwarden-desktop         # Passwort-Manager zur sicheren Verwaltung deiner Zugangsdaten
    onlyoffice-desktopeditors # Office-Suite mit sehr hoher Kompatibilität zu MS Office-Formaten
    insync                    # Synchronisations-Client für Google Drive und OneDrive
    kicad                     # Professionelles Werkzeug für Elektronik-Design und Platinen-Layout (EDA)

    # --- Entwicklung & System-Tools ---
    nodejs                    # JavaScript-Laufzeitumgebung für Server- und Frontend-Entwicklung
    glab                      # GitLab CLI - Ermöglicht GitLab-Aktionen (wie Login/Push) im Terminal
    distrobox                 # Erlaubt es, andere Linux-Distros (wie Ubuntu/Arch) in Containern zu nutzen
    antigravity               # Ein spezieller Port/Fork für VS Codium/VS Code optimiert
    dos2unix                  # Werkzeug zum Umwandeln von Windows-Zeilenumbrüchen in Linux-Format

    # --- Grafik & Gaming ---
    vulkan-tools              # Diagnose-Tools für die Vulkan-Grafik-Schnittstelle (z.B. vulkaninfo)
    mesa-demos                # Enthält Tools wie glxinfo, um die GPU-Beschleunigung zu prüfen
    gamescope                 # Micro-Compositor von Valve für stabileres Gaming und Upscaling
    kdePackages.qtmultimedia  # Multimedia-Bibliotheken für QT-Anwendungen (wichtig für einige Player/UIs)

    # --- Keyboard & Hardware ---
    qmk                       # CLI-Tool zum Flashen von mechanischen Tastaturen mit QMK-Firmware
    vial                      # GUI zur Echtzeit-Konfiguration von Tastatur-Keymaps (Vial-Firmware)

    # --- Custom Desktop Items (Web-Apps) ---
    # Erstellt einen Menü-Eintrag, der Microsoft 365 als "App" (Web-Wrapper) über Vivaldi startet
    (makeDesktopItem {
      name = "ms-office-365";
      desktopName = "Microsoft 365";
      exec = "${pkgs.vivaldi}/bin/vivaldi --app=\"https://www.office.com/?auth=2\"";
      icon = "vivaldi";
      categories = [ "Office" ];
    })
    
    # --- Platzhalter für optionale v2 (Affinity Suite via Nix) ---
    # inputs.affinity-nix.packages.${pkgs.system}.designer
    # inputs.affinity-nix.packages.${pkgs.system}.photo
    # inputs.affinity-nix.packages.${pkgs.system}.publisher
  ];
}
