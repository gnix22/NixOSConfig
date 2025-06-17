{
  config,
  lib,
  pkgs,
  ...
}:

{
  imports = [
    ./components
  ];

  environment.systemPackages = with pkgs; [
    brightnessctl
    neovim
    grim
    slurp
  ];
  
  home-manager.users.gnix = {

    wayland.windowManager.hyprland = {
      enable = true;

      settings = {
        "$mod" = "SUPER";

        xwayland.force_zero_scaling = true; 

        monitor = [
          ", 1920x1080, auto, 1"
        ];

        exec-once = [
          "hyprpaper"
          "kitty"
          "udiskie"
        ]; 

        env = [
          "GDK_SCALE, 1"
          "HYPRCURSOR_THEME, rose-pine-hyprcursor"
          "HYPRCURSOR_SIZE, 20"
        ];

        windowrulev2 = [
          "float, class:brave, title:^(.* wants to (open|save))$"
          "float, class:xdg-desktop-portal-gtk, title:^(.* wants to (open|save))$"
        ];

        ### Appearance ###

        general =
          let
            accent = "rgba(ffffffff)";
            base = "rgba(ff0000ff)";
          in
          {
            "border_size" = 1;
            "gaps_in" = 5;
            "col.active_border" = accent;
            "col.inactive_border" = base;
            "resize_on_border" = true;
          };

        decoration = {
          "rounding" = 0;
          "active_opacity" = 0.95;
          "inactive_opacity" = 0.75;
        };

        #blur = {
        #  "enabled" = true;
        #  "size" = 2;
        #  "passes" = 1;
        #  "vibrancy" = 0.1696;
        #};

        misc = {
          "disable_hyprland_logo" = true;
        };

        ### Input and Keybinds ###

        input = {
          "kb_layout" = "us";
          "natural_scroll" = false;

          touchpad = {
            "natural_scroll" = false;
          };
        };

        bind = [
          # General
          "$mod, C, killactive"
          "Alt_L, Space, exec, fuzzel"
          "$mod, Q, exec, kitty"
          "$mod, M, exit"
          "$mod, O, exec, obsidian"

          # Fullscreen control
          "$mod, G, fullscreen, 1"
          "$mod+Shift, G, fullscreen, 0"

          # Float
          "$mod, F, togglefloating"
          "$mod, F, centerwindow"
          "$mod, F, resizeactive, exact 65% 65%"

          # Minimize trick
          "$mod, Z, togglespecialworkspace, mincontainer"
          "$mod, Z, movetoworkspace, +0"
          "$mod, Z, togglespecialworkspace, mincontainer"
          "$mod, Z, movetoworkspace, special:mincontainer"
          "$mod, Z, togglespecialworkspace, mincontainer"

          # System Power
          "$mod, L, exec, hyprlock"
          "$mod, V, exec, hyprctl dispatch exit"
          "$mod+Shift, V, exec, shutdown now"

          # Keyboard navigation
          "Alt_L, H, movefocus, l"
          "Alt_L, J, movefocus, d"
          "Alt_L, K, movefocus, u"
          "Alt_L, L, movefocus, r"

          "$mod+Shift, H, movewindow, l"
          "$mod+Shift, J, movewindow, d"
          "$mod+Shift, K, movewindow, u"
          "$mod+Shift, L, movewindow, r"

          "$mod, 1, workspace, 1"
          "$mod, 2, workspace, 2"
          "$mod, 3, workspace, 3"
          "$mod, 4, workspace, 4"
          "$mod+Shift, 1, movetoworkspace, 1"
          "$mod+Shift, 2, movetoworkspace, 2"
          "$mod+Shift, 3, movetoworkspace, 3"
          "$mod+Shift, 4, movetoworkspace, 4"

          # Keyboard Layouts
          "Alt_L, Shift_L, exec, hyprctl switchxkblayout at-translated-set-2-keyboard next"
          "Alt_L, Shift_L, exec, hyprctl switchxkblayout keychron-keychron-c2 next"
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
}
