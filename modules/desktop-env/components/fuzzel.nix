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
          background = "#ff6ec7aa";
          text = "#ffffffff";
          prompt = "#ffffffff";
        };
      };
    };
  };
}

