{ ... }:

{
  home-manager.users.gnix = {
    programs.wezterm = {
      enable = true;
      enableBashIntegration = true;
      /* lua */
      extraConfig = ''
        local wezterm = require("wezterm")
        local config = wezterm.config_builder()

        -- font settings 
        config.font = wezterm.font("GohuFont")
        config.font_size = 12

        -- colors 
        config.color_scheme = "Belafonte Night (Gogh)"

        -- tab bar settings
        config.use_fancy_tab_bar = false
        config.hide_tab_bar_if_only_one_tab = true
        config.colors = {
          tab_bar = {background = '#000000',
            active_tab = {
              bg_color = '#1C1C1C',
              fg_color = '#ffffff',
            },
            inactive_tab = {
              bg_color = '#000000',
              fg_color = '#ffffff',
            },
          },

        }
        -- gets program to load .bashrc
        default_prog = {"bash"}
        return config
      '';
    };
  };
}
