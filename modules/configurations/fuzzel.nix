{ ... }: 

{
  home-manager.users.gnix = {
    programs.fuzzel = {
      enable = true;

      settings = {
        main = {
          font = "mononoki:size 8";
          icon-theme = "Papirus-Dark";

        };
        
        colors = {
          background = "#6699CC00";
          text = "#ffffffff";
          prompt = "#ffffffff";
        };
      };
    };
  };
}

