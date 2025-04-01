{ ... }:

{
  home-manager.users.gnix = {
    programs.git = {
      enable = true;
      userName = "gnix22";
      userEmail = "gjnix22@gmail.com";
      extraConfig = {
        init.defaultBranch = "main";
      };
    };
  };
}
