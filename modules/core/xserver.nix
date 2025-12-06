{ host, ... }:
let
  vars = import ../../hosts/${host}/variables.nix;
  keyboardLayout = vars.keyboardLayout or "us";
  keyboardVariant = vars.keyboardVariant or "";
  layoutIsVariant = builtins.elem keyboardLayout [ "dvorak" "colemak" "workman" "intl" "us-intl" ];
  xkbLayout = if (keyboardVariant != "" || layoutIsVariant) then "us" else keyboardLayout;
  xkbVariant = if (keyboardVariant != "") then keyboardVariant else if layoutIsVariant then keyboardLayout else "";
in
{
  services.xserver = {
    enable = false;
    xkb = {
      layout = xkbLayout;
      variant = xkbVariant;
    };
  };
}
