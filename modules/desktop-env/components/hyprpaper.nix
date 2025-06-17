{ config, lib, ... }:

{
  home-manager.users.gnix = {
    services.hyprpaper = {
      enable = true;

      settings =
        let
          wp-path = "${../../../assets/wallpapers/a_colorful_buildings_with_power_lines.jpg}";
        in
        {
          preload = [
            wp-path
          ];

          wallpaper = [
            ",${wp-path}"
          ];
        };
    };
  };
}
