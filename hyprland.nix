{ config, lib, pkgs, ... }:

{
  imports = [
    ./modules/configurations
  ]; 

  config = {
    programs.hyprland.enable = true;

    environment.systemPackages = with pkgs; [
      brightnessctl
      grim
      slurp
    ];

    home-manager.users.gnix = {

      wayland.windowManager.hyprland = {
        enable = true;

        settings = {
          "$mainMod" = "SUPER";

          exec-once = [
            "hyprpaper"
            "kitty"
            "waybar"
            "udiskie"
          ];

          xwayland.force_zero_scaling = true;

          env = [
            "XCURSOR_SIZE,15"
            "HYPRCURSOR_SIZE,10"
          ];

          general = {
            "gaps_in" = 5;
            "gaps_out" = 20;
            "border_size" = 1;

            "col.active_border" = "rgba(ffffffee)";
            "col.inactive_border" = "rgba(ff0000aa)";
          };

          decoration = {
            "rounding" = 0;
            "active_opacity" = 0.95;
            "inactive_opacity" = 0.5;
          };

          blur = {
            "enabled" = true;
            "size" = 2;
            "passes" = 1;

            "vibrancy" = 0.1696;
          };

          misc = {
            disable_hyprland_logo = true;
          };

          input = {
            "kb_layout" = "us";
            "natural_scroll" = false;
            touchpad = {
              "natural_scroll" = false;
            };
          };

          bind = [
            "$mainMod, Q, exec, kitty"  
            "$mainMod, C, killactive"  
            "$mainMod, M, exit"  
            "$mainMod, E, exec, nautilus"  
            "$mainMod, V, togglefloating"  
            "$mainMod, R, exec, fuzzel"  
            "$mainMod, P, pseudo"  # dwindle  
            "$mainMod, J, togglesplit"  # dwindle  
            "$mainMod, O, exec, obsidian"  

            "$mainMod, left, movefocus, l"  
            "$mainMod, right, movefocus, r"  
            "$mainMod, up, movefocus, u"  
            "$mainMod, down, movefocus, d"  

            "$mainMod, 1, workspace, 1"  
            "$mainMod, 2, workspace, 2"  
            "$mainMod, 3, workspace, 3"  
            "$mainMod, 4, workspace, 4"  
            "$mainMod, 5, workspace, 5"  
            "$mainMod, 6, workspace, 6"  
            "$mainMod, 7, workspace, 7"  
            "$mainMod, 8, workspace, 8"  
            "$mainMod, 9, workspace, 9"  
            "$mainMod, 0, workspace, 10"  

            "$mainMod SHIFT, 1, movetoworkspace, 1"  
            "$mainMod SHIFT, 2, movetoworkspace, 2"  
            "$mainMod SHIFT, 3, movetoworkspace, 3"  
            "$mainMod SHIFT, 4, movetoworkspace, 4"  
            "$mainMod SHIFT, 5, movetoworkspace, 5"  
            "$mainMod SHIFT, 6, movetoworkspace, 6"  
            "$mainMod SHIFT, 7, movetoworkspace, 7"  
            "$mainMod SHIFT, 8, movetoworkspace, 8"  
            "$mainMod SHIFT, 9, movetoworkspace, 9"  
            "$mainMod SHIFT, 0, movetoworkspace, 10"  

            "$mainMod, S, togglespecialworkspace, magic"  
            "$mainMod SHIFT, S, movetoworkspace, special:magic"  

            "$mainMod, mouse_down, workspace, e+1"  
            "$mainMod, mouse_up, workspace, e-1"  

            "$mainMod, mouse:272, movewindow"  
            "$mainMod, mouse:273, resizewindow"  
          ];
                    # Sound
          bindel = [
            ", XF86AudioRaiseVolume, exec, wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%+"
            ", XF86AudioLowerVolume, exec, wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-"
            ", XF86MonBrightnessDown, exec, brightnessctl set 10%-"
            ", XF86MonBrightnessUp, exec, brightnessctl set 10%+"
          ];

          bindl = [
            ", XF86AudioRaiseVolume, exec, wpctl set-mute @DEFAULT_AUDIO_SINK@ 0"
            ", XF86AudioMute, exec, wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"
          ];

          # Mouse Navigation
          bindm = [
            "$mod, mouse:272, movewindow"
            "$mod, mouse:273, resizewindow"
          ];
        };
      };
    
    };
  };
}
