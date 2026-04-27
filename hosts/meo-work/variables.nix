{
  # Git Configuration
  gitUsername = "Meo98";
  gitEmail = "chenevard.romeo@gmail.com";

  # Display Manager
  displayManager = "sddm";

  # Bundled Applications
  tmuxEnable = false;
  alacrittyEnable = false;
  weztermEnable = false;
  ghosttyEnable = false;
  vscodeEnable = false;
  antigravityEnable = false;
  helixEnable = true;
  doomEmacsEnable = false;

  # Hyprland Monitor Settings
  # Arbeitslaptop: nur internes Display, auto-Auflösung
  # Nach der Installation kannst du mit `hyprctl monitors` die echten Namen prüfen
  # und hier z.B. auf "eDP-1,1920x1080@60,auto,1" anpassen.
  extraMonitorSettings = ''
    monitor = ,preferred,auto,1
  '';

  # Bar/Shell
  barChoice = "noctalia";

  # Waybar Settings
  clock24h = true;

  # Browser (muss in host-packages.nix installiert sein)
  browser = "vivaldi";

  # Terminal
  terminal = "kitty";

  # Keyboard Layout (Schweizer Deutsch)
  keyboardLayout = "ch";
  consoleKeyMap = "sg";

  # GPU IDs (nicht benötigt für Intel-only, Platzhalter)
  intelID = "PCI:0:2:0";
  amdgpuID = "PCI:0:0:0";
  nvidiaID = "PCI:0:0:0";

  # Affinity Suite (deaktiviert, da kein affinity.nix importiert)
  enableAffinity = false;

  # NFS
  enableNFS = true;

  # Drucken
  printEnable = false;

  # Dateimanager
  thunarEnable = false;

  # Wallpaper & Theming
  stylixImage = ../../wallpapers/Anime-Purple-eyes.png;

  waybarChoice = ../../modules/home/waybar/waybar-ddubs.nix;

  animChoice = ../../modules/home/hyprland/animations-def.nix;

  # hostId (muss eindeutig sein, für ZFS)
  hostId = "1d713ceb";
}
