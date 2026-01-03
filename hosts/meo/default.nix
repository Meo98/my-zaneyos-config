{ pkgs, ... }: {
  imports = [
    ./hardware.nix
    ./host-packages.nix
    ./kanata.nix
    ./affinity.nix
  ];

  programs.kdeconnect.enable = true;

  # --- NEU: GNOME KEYRING FÜR BAMBU STUDIO ---
  # Damit Passwörter gespeichert werden können
  services.gnome.gnome-keyring.enable = true;
  programs.seahorse.enable = true; # GUI um Passwörter anzusehen/zu löschen

  # WICHTIG: Damit der Keyring beim Login entsperrt wird.
  # Wenn du einen Login-Manager wie SDDM oder Greetd nutzt, musst du
  # eventuell auch diese aktivieren (einfach das # entfernen):
  # security.pam.services.sddm.enableGnomeKeyring = true;
  # security.pam.services.greetd.enableGnomeKeyring = true; 
  
  # Standard für Konsolen-Login oder generellen Fall:
  security.pam.services.login.enableGnomeKeyring = true; 
  # -------------------------------------------

  services.udev.extraRules = ''
    # Keychron Geräte (Vendor ID 3434)
    KERNEL=="hidraw*", SUBSYSTEM=="hidraw", ATTRS{idVendor}=="3434", MODE="0666", TAG+="uaccess"

    # STM32 Bootloader (Wichtig für das Flashen/Firmware-Updates)
    SUBSYSTEM=="usb", ATTRS{idVendor}=="0483", ATTRS{idProduct}=="df11", MODE="0666", TAG+="uaccess"

    # Keychron Link Dongle
    SUBSYSTEM=="usb", ATTRS{idVendor}=="3434", MODE="0666", TAG+="uaccess"
  '';

  # --- BENUTZER & GRUPPEN ---
  users.users."meo".extraGroups = [ "dialout" "input" "uinput" ];

  # --- STANDARD ANWENDUNGEN ---
  xdg.mime.defaultApplications = {
    "text/html" = "vivaldi-stable.desktop";
    "x-scheme-handler/http" = "vivaldi-stable.desktop";
    "x-scheme-handler/https" = "vivaldi-stable.desktop";
    "x-scheme-handler/about" = "vivaldi-stable.desktop";
    "x-scheme-handler/unknown" = "vivaldi-stable.desktop";
  };
}
