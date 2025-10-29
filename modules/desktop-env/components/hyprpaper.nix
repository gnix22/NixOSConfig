{ config, lib, ... }:

{
  home-manager.users.gnix = {
    services.hyprpaper = {
      enable = true;

      settings =
        let
          wp-path = "${../../../assets/wallpapers/a_video_game_screen_with_trees_and_bushes.jpg}";
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
