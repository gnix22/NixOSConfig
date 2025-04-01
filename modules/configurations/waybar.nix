{ config, ... }:

{
  home-manager.users.gnix = {
    programs.waybar = {
    enable = true;
    systemd.enable = true;


      style = with config.colors; ''
        @define-color base rgb(255,255,255);
        @define-color acc  rgb(255,255,255);
        @define-color text rgb(255,255,255);

        * {
          font-family: mononoki;
        }

        window#waybar {
          background: transparent;
        }

        #window {
          color: transparent;
          background: transparent;
        }

        tooltip {
          color: @text;
          background: @base;

          padding: 5px;

          border: 3px solid @acc;
          border-radius: 10px;
        }

        .module {
          color: @text;

          padding: 0 7px;
        }
	
	#battery {
	  color: @acc;
	  padding: 8px;
        }	

        #network {
          padding: 8px;
        }

        #bluetooth {
          padding: 8px;
        }

        #custom-nix {
          color: @acc;

          font-size: 1.4em;
        }

        #custom-power {
          color: @acc;
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
	"network"
        "battery"
        "custom/power"
      ];

      # configuring the icons
      battery = {
       format-discharging = "batt. dischar. {capacity}%";
       format-charging = "batt. char. {capacity}%";
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
         format = "⏻ ";
         tooltip = false;
         menu = "on-click";
         menu-file = "${./power-menu.xml}";
         menu-actions = {
         logout = "hyprctl dispatch exit";
         shutdown = "shutdown now";
         reboot = "reboot";
         };
       };

       network = {
         format-wifi = "wi-fi {bandwidthDownBits}" ;
         format-disconnected = "err: no wi-fi ";
         format-ethernet = "ethernet {bandwidthDownBits}";
         #on-click = "hyprctl dispatch exec '[float; size 80%] kitty nmtui connect'";
         tooltip = false;
	 interval = 5;
       };

      };
    };
   };
 };
}
