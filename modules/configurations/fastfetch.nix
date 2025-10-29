{ config, ... }:

{ 
  home-manager.users.gnix = {
    programs.fastfetch = {
      enable = true;

      settings = {
	logo = {
	  source = "${../../assets/logo2.txt}";
	  color = {"1" = "white";};
        };
	display = {
            separator = "  ";
            size.binaryPrefix = "si";
            size = {
              maxPrefix = "TB";
              ndigits = 2;
            };
            bar = {
              char.elapsed = "=";
              charTotal = "-";
              border.left = "[";
              border.right = "]";
            };
            percent = {
              type = 1;
            };
            color = {
              keys = "white";
              output = "default";
            };
          };

        # Modules
        modules = [

          # First Module Group
          "break"
          "break"
          {
            type = "title";
          }
          {
            type = "separator";
            string = "▔";
          }
          {
            type = "datetime";
            key = "╭─";
            format = "{14}:{17}:{20}";
          }
          {
            type = "datetime";
            key = "├─󰸗";
            format = "{1}-{3}-{11}";
          }
          {
            type = "uptime";
            key = "╰─󰔚";
          }
          "break"

          # Second Module Group
          {
            type = "os";
            key = "╭─";
            format = "{3} ({12})";
          }
          {
            type = "cpu";
            key = "├─";
            freqNdigits = 1;
          }
          {
            type = "board";
            key = "├─󱤓";
          }
          {
            type = "gpu";
            key = "├─󰢮";
            format = "{1} {2}";
          }
          {
            type = "sound";
            key = "├─󰓃";
            format = "{2}";
          }
          {
            type = "memory";
            key = "├─";
            format = "{2} RAM";
          }
          {
            type = "disk";
            key = "├─󰋊";
            format = "{2} DSK";
          }
          {
            type = "localip";
            key = "╰─󱦂";
            showIpv4 = true;
            compact = true;
          }
        ];  
      };
    };
  };
}
