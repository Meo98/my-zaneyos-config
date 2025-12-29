{ config, pkgs, ... }:

let
  gemini-launcher = pkgs.writeShellScriptBin "gemini-launcher" ''
    #!${pkgs.bash}/bin/bash
    
    # Pfad zum API Key
    KEY_FILE="${config.home.homeDirectory}/gem.key"

    # API Key laden falls vorhanden
    if [ -f "$KEY_FILE" ]; then
      source "$KEY_FILE"
    fi

    # Wir nutzen npx, um immer die aktuellste Version von gemini-cli zu starten
    # Das stellt sicher, dass Version > 0.16.0 (für Gemini 3 Pro) genutzt wird.
    exec ${pkgs.kitty}/bin/kitty -e ${pkgs.nodejs}/bin/npx -y @google/gemini-cli@latest
  '';

in
{
  home.packages = [
    pkgs.nodejs # npx wird benötigt
    gemini-launcher
  ];

  xdg.desktopEntries.gemini-cli = {
    name = "Gemini CLI";
    comment = "Launch the Gemini CLI in Kitty terminal";
    icon = "utilities-terminal";
    exec = "gemini-launcher";
    terminal = false;
    type = "Application";
    categories = [ "Development" "Utility" ];
  };
}
