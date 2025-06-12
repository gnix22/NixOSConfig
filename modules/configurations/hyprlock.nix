{ config, ... }:

{
  home-manager.users.gnix = 
  let
  base = "rgba(255, 99, 134, 1)";
  accent = "rgba(255,192,203,1)";
  text = accent;
  fail = "rgba(0,0,0,1)";
  in
  {
    programs.hyprlock = {
      enable = true;

        settings = {
          background = {
            monitor = "";
            path = "${../../assets/wallpapers/a_colorful_buildings_with_power_lines.jpg}";

            blur_passes = 2;
          };

          input-field = {
            monitor = "";
            size = "75%, 75%";
            fade_on_empty = false;

            halign = "center";
            valign = "center";
            position = "0, -5%";

            outer_color = accent;
            inner_color = base;
            font_color = text;
            check_color = text;
            fail_color = fail;
          };
          # for time 
          label = {
            monitor = "";
            text = ''cmd[update:1000] echo "$(date +"%-I:%M")"'';
            font_size = 95;
            font_family = "mononoki";

            halign = "center";
            valign = "center";
            position = "0, 200";

            color = accent;
          };

          image = {
            monitor = "";
            path = "${../../assets/wallpapers/cowboypfp.jpg}";
            size = 100;
            rounding = -1;
            halign = "center";
            valign = "bottom";

            border_color = accent;
          };
        };
      };
    };
}
