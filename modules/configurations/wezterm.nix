{ ... }:

{
  home-manager.users.gnix = {
    programs.wezterm = {
      enable = true;
      enableBashIntegration = true;
      extraConfig = ''
        local wezterm = require("wezterm")
        return {
          font = wezterm.font("GohuFont"),
          font_size = 12,
          default_prog = { "bash" },
        }
      '';
    };
  };
}
