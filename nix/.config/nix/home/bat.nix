{...}: {
  programs.bat = {
    enable = true;
    config = {
      theme = "tokyo_night";
    };
    themes = {
      tokyo_night = {
        file = "./tokyonight_night.tmTheme";
      };
    };
  };
}
