{ ... }: 

{
  home-manager.users.gnix = {
    programs.fuzzel = {
      enable = true;

      settings = {
        main = {
          font = "GohuFont:size 8";
          icon-theme = "Papirus-Dark";

        };
        
        colors = {
          background = "#0000000a";
          text = "#ffffffff";
          prompt = "#ffffffff";
        };
      };
    };
  };
}

