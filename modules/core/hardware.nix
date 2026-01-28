{pkgs, ...}: {
  hardware = {
    sane = {
      enable = true;
      extraBackends = [pkgs.sane-airscan];
      disabledDefaultBackends = ["escl"];
    };
    logitech.wireless.enable = false;
    logitech.wireless.enableGraphical = false;
    graphics.enable = true;
    enableRedistributableFirmware = true;
    keyboard.qmk.enable = true;

    # --- HIER IST DIE ÄNDERUNG ---
    # Wir machen aus "bluetooth.enable" einen Block "bluetooth = { ... }"
    bluetooth = {
      enable = true;
      powerOnBoot = true;
      settings = {
        General = {
          # Spoofing als Apple-Gerät (004C), damit LibrePods Features freischaltet
          DeviceID = "bluetooth:004C:0000:0000";
          
          # Zeigt Akku-Prozentwerte in Widgets/Waybar an
          Experimental = true;
        };
      };
    };
    # -----------------------------
  };
  local.hardware-clock.enable = false;
}
