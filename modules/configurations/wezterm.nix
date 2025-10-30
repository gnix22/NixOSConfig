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
          color_scheme = "Belafonte Night (Gogh)",
          font_size = 12,
          default_prog = { "bash" },
        }
      '';
    };
  };
}
