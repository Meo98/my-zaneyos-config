{ config, pkgs, ... }:

{
  hardware.uinput.enable = true;
  services.udev.packages = [ pkgs.kanata ];

  services.kanata = {
    enable = true;

    keyboards = {
      "meo-config" = {
        extraDefCfg = ''
          process-unmapped-keys yes
        '';

        config = ''
          (defsrc
            caps a s d f g h j k l u i
            n w e r x c v spc
            lbrc apos scln
          )

          ;; --- CHORDS ---
          ;; u+i => Enter (Solo-Fälle explizit mappen!)
          (defchords enter_chord 80
            (u  ) u
            (  i) i
            (u i) ret
          )

          ;; w+e => Backspace (Solo-Fälle explizit mappen!)
          (defchords bs_chord 40
            (w  ) w
            (  e) e
            (w e) bspc
          )

          (defalias
            ;; --- Basic Macros ---
            k0 0 k4 4 k6 6 kc c kd d
            Ue (macro 20 C-S-u 900 @k0 30 @k0 30 @kd 30 @kc 30 ret)
            Oe (macro 20 C-S-u 900 @k0 30 @k0 30 @kd 30 @k6 30 ret)
            Ae (macro 20 C-S-u 900 @k0 30 @k0 30 @kc 30 @k4 30 ret)

            ;; --- Chord-Keys ---
            my_u (chord enter_chord u)
            my_i (chord enter_chord i)

            my_w (chord bs_chord w)
            my_e (chord bs_chord e)

            ;; --- Caps: tap = Esc, hold = Super ---
            cap (tap-hold 200 200 esc lmet)

            ;; --- Home-row mods ---
            met_g (tap-hold 200 200 g lmet)
            alt_s (tap-hold 200 200 s lalt)
            ctl_f (tap-hold 200 200 f lctl)
            sft_d (tap-hold 200 200 d lsft)

            met_h (tap-hold 200 200 h rmet)
            alt_l (tap-hold 200 200 l ralt)
            ctl_j (tap-hold 200 200 j rctl)
            sft_k (tap-hold 200 200 k rsft)

            ;; Umlaute
            ue_s (tap-hold 200 200 lbrc @Ue)
            oe_s (tap-hold 200 200 scln @Oe)
            ae_s (tap-hold 200 200 apos @Ae)

            ;; Numbers
            numL (layer-while-held numbers)
            n_num (tap-hold-release 200 200 n @numL)
          )

          (deflayer default
            @cap a @alt_s @sft_d @ctl_f @met_g @met_h @ctl_j @sft_k @alt_l @my_u @my_i
            @n_num @my_w @my_e r x c v spc
            @ue_s @ae_s @oe_s
          )

          (deflayer numbers
            @cap a 4 5 6 g h j k l _ _
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
