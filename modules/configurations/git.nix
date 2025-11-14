{ pkgs, ... }:

{
  home-manager.users.gnix = {
    home.packages = with pkgs; [
      git-filter-repo
    ];
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
