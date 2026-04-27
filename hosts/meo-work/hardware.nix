# WICHTIG: Diese Datei muss nach der NixOS-Installation ersetzt werden!
# Führe auf dem Arbeitslaptop aus: sudo nixos-generate-config
# Dann kopiere den Inhalt von /etc/nixos/hardware-configuration.nix hierher.
#
# Die UUIDs unten sind PLATZHALTER und passen nicht zu deinem Gerät.
# Ersetze sie mit den echten UUIDs von: lsblk -o NAME,UUID,FSTYPE
{ config, lib, pkgs, modulesPath, ... }:

{
  imports =
    [ (modulesPath + "/installer/scan/not-detected.nix")
    ];

  # Intel i7-1165G7 (Tiger Lake) - typische Kernel-Module
  boot.initrd.availableKernelModules = [ "xhci_pci" "thunderbolt" "vmd" "nvme" "usbhid" "usb_storage" "sd_mod" "rtsx_pci_sdmmc" ];
  boot.initrd.kernelModules = [ ];
  boot.kernelModules = [ "kvm-intel" ];
  boot.extraModulePackages = [ ];

  # PLATZHALTER - ersetze mit echten UUIDs nach nixos-generate-config
  fileSystems."/" =
    { device = "/dev/disk/by-uuid/ERSETZE-MIT-ECHTER-ROOT-UUID";
      fsType = "ext4";
    };

  fileSystems."/boot" =
    { device = "/dev/disk/by-uuid/ERSETZE-MIT-ECHTER-BOOT-UUID";
      fsType = "vfat";
      options = [ "fmask=0077" "dmask=0077" ];
    };

  swapDevices = [ ];

  networking.useDHCP = lib.mkDefault true;

  nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";
  hardware.cpu.intel.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;
}
