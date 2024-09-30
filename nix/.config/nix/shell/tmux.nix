{
  config,
  pkgs,
  lib,
  ...
}: {
  programs.tmux = {
    enable = true;
    shortcut = "o";
    baseIndex = 1;
    escapeTime = 0;
    historyLimit = 10000;
    keyMode = "vi";
    terminal = "xterm-kitty";

    plugins = with pkgs; [
      tmuxPlugins.sensible
      tmuxPlugins.better-mouse-mode
      {
        plugin = tmuxPlugins.resurrect;
        extraConfig = ''
          set -g @resurrect-strategy-vim 'session'
          set -g @resurrect-strategy-nvim 'session'
          set -g @resurrect-capture-pane-contents 'on'
        '';
      }
      {
        plugin = tmuxPlugins.continuum;
        extraConfig = ''
          set -g @continuum-restore 'on'
          set -g @continuum-boot 'on'
          set -g @continuum-save-interval '10'
        '';
      }
      {
        plugin = tmuxPlugins.tokyo-night-tmux;
        extraConfig = ''
          set -g @tokyo-night-tmux_window_id_style digital
          set -g @tokyo-night-tmux_pane_id_style hsquare
          set -g @tokyo-night-tmux_zoom_id_style dsquare

          set -g @tokyo-night-tmux_show_path 1
          set -g @tokyo-night-tmux_path_format relative # 'relative' or 'full'

          set -g @tokyo-night-tmux_show_netspeed 1
          set -g @tokyo-night-tmux_netspeed_iface "en0" # Detected via default route
          set -g @tokyo-night-tmux_netspeed_showip 1      # Display IPv4 address (default 0)
          set -g @tokyo-night-tmux_netspeed_refresh 1     # Update interval in seconds (default 1)
        '';
      }
    ];

    extraConfig = lib.strings.fileContents ./tmux.conf;
  };
}
