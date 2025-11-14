{ config, ... }:

{
  home-manager.users.gnix = {
    programs.waybar = {
    enable = true;
    systemd.enable = true;


      style = ''
        @define-color base rgba(255,255,255, 1);
        @define-color acc  rgba(0, 0, 1, 0.25);
        @define-color text rgba(255,255,255, 1);

        * {
          font-family: GohuFont;
        }

        window#waybar {
          color: @base;
          background: transparent;
        }

        .modules-left {
          border-radius: 12px;
          background: @acc;
          padding: 0 8px;

        }

        .modules-right,
        .modules-center {
          border-radius: 12px;
          background: transparent;
          padding: 0 8px;
        }

        #window {
          color: transparent;
          background: transparent;
        }

        #workspaces {
          background: transparent;
          border-radius: 8px;
        }

        tooltip {
          color: @text;
          background: transparent;

          padding: 5px;

          border: 3px solid @acc;
          border-radius: 10px;
        }

        #battery {
          color: @base;
          padding: 2px;
        }

        #network {
          color: @base;
          padding: 2px;
        }

        #custom-nix {
          color: @base;

          font-size: 1.4em;
        }

        #custom-power {
          color: @base;
          padding: 2px;
        }

        #clock {
          color: @base;
        }

        #clock calendar {
          color: rgba(255, 255, 255, 1);
          background: transparent;
        }

        #clock calendar:selected {
          background: rgba(0, 0, 255, 0.5);
          color: rgba(255, 255, 255, 1);
        }

        #clock calendar-header {
          color: rgba(255, 255, 255, 1);
          font-weight: bold;
        }

        #pulseaudio {
          color: @base;
          padding: 2px;
        }

        #workspaces button.active {
          color: @base;
          background: transparent;
        }
      '';



    settings = {
      mainbar = {
        layer = "top";
        position = "top";
        height = 38;
        spacing = 2;


        modules-left = [
          "hyprland/workspaces"
        ];

        modules-center = [
          "clock"
        ];

        modules-right = [
          "pulseaudio"
          "custom/sep"
          "network"
          "custom/sep"
          "battery"
          "custom/sep"
          "custom/power"
        ];

        # configuring the icons
        battery = {
         format-discharging = "d.{capacity}%";
         format-charging = "c.{capacity}%";
         interval = 1;
        };

        clock = {
           format = "{:%b %d  %H:%M}";
           tooltip-format = "{:%H:%M:%S  %a. %B %d, %Y}\n\n{calendar}";
           calendar = {
           mode = "month";
           mode-mon-col = 3;
           };
           actions = {
           on-click = "mode";
           };
           interval = 1;
        };

        "custom/power" = {
           format = " ";
           tooltip = false;
           menu = "on-click";
           menu-file = "${./power-menu.xml}";
           menu-actions = {
           logout = "hyprctl dispatch exit";
           shutdown = "shutdown now";
           reboot = "reboot";
           };
        };
        
        "custom/sep" = {
          format = " --//-- ";
        };

        network = {
           format-wifi = "  {bandwidthDownBits}" ;
           format-disconnected = "err: no wi-fi ";
           format-ethernet = "ethernet {bandwidthDownBits}";
           on-click = "hyprctl dispatch exec '[float; size 80%] kitty nmtui connect'";
           tooltip = false;
           interval = 5;
        };

        pulseaudio = {
          format = "  {volume}%";
          format-muted = "  muted";
        };

      };
    };
   };
 };
}
