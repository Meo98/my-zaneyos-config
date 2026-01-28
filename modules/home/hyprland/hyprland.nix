{
  host,
  config,
  pkgs,
  lib,
  ...
}: let
  vars = import ../../../hosts/${host}/variables.nix;
  dp1X = 1600;
  hyprKbLayout = "ch";
  hyprKbVariant = "de";
in {
  home.packages = with pkgs; [
    swww
    grim
    slurp
    wl-clipboard
    swappy
    ydotool
    hyprpolkitagent
    hyprshot
    hyprpicker
  ];
  
  systemd.user.targets.hyprland-session.Unit.Wants = [
    "xdg-desktop-autostart.target"
  ];
  
  home.file = {
    "Pictures/Wallpapers" = {
      source = ../../../wallpapers;
      recursive = true;
    };
    ".face.icon".source = ./face.jpg;
    ".config/face.jpg".source = ./face.jpg;
  };

  wayland.windowManager.hyprland = {
    enable = true;
    package = pkgs.hyprland;
    
    systemd = {
      enable = true;
      enableXdgAutostart = true;
      variables = ["--all"];
    };
    
    xwayland = {
      enable = true;
    };

    settings = {
      "$mod" = "SUPER";

      exec-once = [
        "systemctl --user start gnome-keyring-daemon"
        "/home/meo/keyball-layer-popup/start.sh"
      ];

      monitor = [
        "eDP-1,2560x1600@240,0x0,1.6"
        "DP-1,2560x1440@60,${toString dp1X}x0,1"
      ];

      general = {
        layout = "dwindle";
        gaps_in = 6;
        gaps_out = 8;
        border_size = 2;
        resize_on_border = true;
        "col.active_border" = "rgb(${config.lib.stylix.colors.base08}) rgb(${config.lib.stylix.colors.base0C}) 45deg";
        "col.inactive_border" = "rgb(${config.lib.stylix.colors.base01})";
      };

      input = {
        kb_layout = hyprKbLayout;
        kb_options = "grp:alt_caps_toggle";
        numlock_by_default = true;
        repeat_delay = 300;
        follow_mouse = 1;
        float_switch_override_focus = 0;
        sensitivity = 0;
        touchpad = {
          natural_scroll = true;
          disable_while_typing = true;
          scroll_factor = 0.8;
        };
      };

      gestures = {
        workspace_swipe = true;
        workspace_swipe_distance = 500;
        workspace_swipe_invert = true;
        workspace_swipe_min_speed_to_force = 30;
        workspace_swipe_cancel_ratio = 0.5;
        workspace_swipe_create_new = true;
        workspace_swipe_forever = true;
      };

      misc = {
        layers_hog_keyboard_focus = true;
        initial_workspace_tracking = 0;
        mouse_move_enables_dpms = true;
        key_press_enables_dpms = true;
        disable_hyprland_logo = true;
        disable_splash_rendering = true;
        enable_swallow = false;
        vfr = true;
        vrr = 2;
      };
    };

    extraConfig = ''
      monitor=,preferred,auto,auto
      monitor=Virtual-1,1920x1080@60,auto,1
    '';
  };
}
