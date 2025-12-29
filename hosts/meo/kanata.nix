{ config, pkgs, ... }:

{
  hardware.uinput.enable = true;
  services.udev.packages = [ pkgs.kanata ];

  services.kanata = {
    enable = true;

    keyboards = {
      "meo-config" = {
        # gilt für interne + alle angeschlossenen Keyboards (kein devices = [...] )

        extraDefCfg = ''
          process-unmapped-keys yes
        '';

        config = ''
          (defsrc
            caps a s d f g h j k l
            n w e r x c v spc
            lbrc apos scln
          )

          (defalias
            ;; --- Keys, die wir in macros tippen wollen (Zahlen sonst = delays) ---
            k0 0
            k4 4
            k6 6
            kc c
            kd d

            ;; kitty unicode input: Ctrl+Shift+u -> warten -> hex -> Enter
            ;; Ü = U+00DC, Ö = U+00D6, Ä = U+00C4
            Ue (macro 20 C-S-u 900 @k0 30 @k0 30 @kd 30 @kc 30 ret)
            Oe (macro 20 C-S-u 900 @k0 30 @k0 30 @kd 30 @k6 30 ret)
            Ae (macro 20 C-S-u 900 @k0 30 @k0 30 @kc 30 @k4 30 ret)

            ;; Home-row mods
            met_g (tap-hold 200 200 g lmet)
            alt_s (tap-hold 200 200 s lalt)
            ctl_f (tap-hold 200 200 f lctl)
            sft_d (tap-hold 200 200 d lsft)

            met_h (tap-hold 200 200 h rmet)
            alt_l (tap-hold 200 200 l ralt)
            ctl_j (tap-hold 200 200 j rctl)
            sft_k (tap-hold 200 200 k rsft)

            ;; Umlaute: Tap=ü/ä/ö, Hold=Ü/Ä/Ö
            ue_s (tap-hold 200 200 lbrc @Ue)
            oe_s (tap-hold 200 200 scln @Oe)
            ae_s (tap-hold 200 200 apos @Ae)

            ;; ---- Numbers layer auf Hold-N ----
            numL (layer-while-held numbers)
            n_num (tap-hold-release 200 200 n @numL)

            cap (tap-hold 200 200 caps lmet)
          )

          (deflayer default
            @cap a @alt_s @sft_d @ctl_f @met_g @met_h @ctl_j @sft_k @alt_l
            @n_num w e r x c v spc
            @ue_s @ae_s @oe_s
          )


          (deflayer numbers
            @cap a 4 5 6 g h j k l
            n 1 2 3 7 8 9 0
            @ue_s @ae_s @oe_s
          )
        '';
      };
    };
  };

  systemd.services.kanata-meo-config = {
    serviceConfig = {
      DynamicUser = pkgs.lib.mkForce false;
      User = pkgs.lib.mkForce "root";
      Group = pkgs.lib.mkForce "root";
    };
  };
}
