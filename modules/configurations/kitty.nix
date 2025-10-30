{ ... }:

{
  home-manager.users.gnix = {
    programs.kitty = {
      enable = true;

      settings = {
        cursor_trail = 0;

        tab_bar_edge = "top";
        tab_bar_style = "powerline";
        hide_window_decorations = "yes";
        font_family = "mononoki";
        bold_font = "auto";
        italic_font = "auto";
        bold_italic_font = "auto";

        font_size = 12;


        # BEGIN_KITTY_THEME
        # Tropical Neon
        include = "current-theme.conf";
        # END_KITTY_THEME
      };
    };
  };
}
