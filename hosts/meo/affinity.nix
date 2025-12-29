{ config, pkgs, inputs, username, lib, ... }:

let
  vars = import ./variables.nix;
  enabled = (vars.enableAffinity or false);
in
lib.mkIf enabled {

  # ✅ Systemweit nötig für Wine/DXVK/Vulkan (auch wenn Affinity nur im User ist)
  hardware.graphics.enable = lib.mkDefault true;
  hardware.graphics.enable32Bit = lib.mkDefault true;

  # Vulkan Loader + Layers (optional, aber hilfreich)
  hardware.graphics.extraPackages = with pkgs; [
    vulkan-loader
    vulkan-validation-layers
  ];

  hardware.graphics.extraPackages32 = with pkgs.pkgsi686Linux; [
    vulkan-loader
  ];

  # Tools zum Debuggen (du hattest "vulkaninfo: command not found")
  environment.systemPackages = with pkgs; [
    vulkan-tools
  ];

  # ✅ Affinity nur im User-Profil (Home Manager)
  home-manager.users.${username}.home.packages =
    lib.optionals enabled [
      inputs.affinity-nix.packages.${pkgs.system}.v3
    ];
}
