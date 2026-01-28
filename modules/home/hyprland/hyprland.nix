{
  host,
  config,
  pkgs,
  lib,
  ...
}:
let
  vars = import ../../../hosts/${host}/variables.nix;
  dp1X = 1600;
  # ... (deine anderen Variablen bleiben gleich)
  hyprKbLayout = "ch"; # Oder was auch immer deine Variable oben ergibt
  hyprKbVariant = "de";
in
{
  # ... (home.packages etc. bleiben gleich) ...

  wayland.windowManager.hyprland = {
    enable = true;
    package = pkgs.hyprland;
    
    # ... (systemd config bleibt gleich) ...

    settings = {
      
      # --- 1. VARIABLEN (MÜSSEN GANZ OBEN STEHEN) ---
      "$mod" = "SUPER";  # Definiert die Windows-Taste als Haupt-Modifier

      # --- 2. AUTOSTART (EXEC-ONCE) ---
      exec-once = [
        "systemctl --user start gnome-keyring-daemon"
        # "waybar"  <-- Falls du Waybar nutzt, hier einkommentieren
        # "swww init"
        "/home/meo/keyball-layer-popup/start.sh"  # Keyball44 Layer Pop-up Tool
      ];

      # --- 3. MONITORE ---
      monitor = [
        "eDP-1,2560x1600@240,0x0,1.6"
        "DP-1,2560x1440@60,${toString dp1X}x0,1"
      ];

      # --- 4. GENERAL SETTINGS ---
      general = {
        # HIER KEINE VARIABLEN DEFINIEREN!
        layout = "dwindle";
        gaps_in = 6;
        gaps_out = 8;
        border_size = 2;
        resize_on_border = true;
        "col.active_border" = "rgb(${config.lib.stylix.colors.base08}) rgb(${config.lib.stylix.colors.base0C}) 45deg";
        "col.inactive_border" = "rgb(${config.lib.stylix.colors.base01})";
      };

      # ... (Rest deiner Config: input, gestures, misc, decoration etc.) ...

      input = {
          kb_layout = hyprKbLayout;
          kb_options = "grp:alt_caps_toggle";
          numlock_by_default = true;
          # ...
      };
      
      # ...
    };
  };
}
