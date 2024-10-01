{...}: let
  gray = "#414868";
  red = "#f7768e";
  green = "#73daca";
  yellow = "#e0af68";
  blue = "#7aa2f7";
  magenta = "#bb9af7";
  cyan = "#7dcfff";
  white = "#c0caf5";
  cursor_text = "#1a1b26";
  selection_background = "#28344a";
  dark_blue = "#3d59a1";
in {
  programs.kitty = {
    enable = true;

    settings = {
      foreground = "#a9b1d6";
      background = "#1a1b26";
      color0 = "${gray}";
      color8 = "${gray}";
      color1 = "${red}";
      color9 = "${red}";
      color2 = "${green}";
      color10 = "${green}";
      color3 = "${yellow}";
      color11 = "${yellow}";
      color4 = "${blue}";
      color12 = "${blue}";
      color5 = "${magenta}";
      color13 = "${magenta}";
      color6 = "${cyan}";
      color14 = "${cyan}";
      color7 = "${white}";
      color15 = "${white}";
      cursor = "${white}";
      cursor_text_color = "${cursor_text}";
      selection_foreground = "none";
      selection_background = "#28344a";
      url_color = "#9ece6a";
      active_border_color = "${dark_blue}";
      inactive_border_color = "#101014";
      bell_border_color = "#e0af68";

      tab_bar_style = "fade";
      tab_fade = "1";

      active_tab_foreground = "${dark_blue}";
      active_tab_background = "#16161e";
      active_tab_font_style = "bold";

      inactive_tab_foreground = "#787c99";
      inactive_tab_background = "#16161e";
      inactive_tab_font_style = "bold";

      tab_bar_background = "#101014";
      macos_titlebar_color = "#16161e";
    };
  };
}
