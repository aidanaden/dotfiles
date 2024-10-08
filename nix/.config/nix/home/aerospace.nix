{...}: {
  home.file.aerospace = {
    target = ".aerospace.toml";
    text = ''
      # Start AeroSpace at login
      start-at-login = true

      enable-normalization-flatten-containers = false
      enable-normalization-opposite-orientation-for-nested-containers = false

      [gaps]
      inner.horizontal = 5
      inner.vertical   = 5
      outer.left       = 5
      outer.bottom     = 5
      outer.top        = 5
      outer.right      = 5

      [mode.main.binding]
      alt-j = 'focus down'
      alt-k = 'focus up'
      alt-l = 'focus right'
      alt-h = 'focus left'

      alt-shift-j = 'move down'
      alt-shift-k = 'move up'
      alt-shift-l = 'move right'
      alt-shift-h = 'move left'

      # yabai-like config
      # joining windows using alt+ctrl
      alt-ctrl-h = 'join-with left'
      alt-ctrl-j = 'join-with down'
      alt-ctrl-k = 'join-with up'
      alt-ctrl-l = 'join-with right'

      #alt-h = 'split horizontal'
      #alt-v = 'split vertical'

      alt-f = 'fullscreen'

      #alt-d = 'layout v_accordion' # 'layout stacking' in i3
      alt-d = 'layout h_accordion tiles' # 'layout tabbed' in i3
      #alt-e = 'layout tiles horizontal vertical' # 'layout toggle split' in i3

      alt-shift-space = 'layout floating tiling' # 'floating toggle' in i3

      alt-1 = 'workspace 1'
      alt-2 = 'workspace 2'
      alt-3 = 'workspace 3'
      alt-4 = 'workspace 4'
      alt-5 = 'workspace 5'
      alt-6 = 'workspace 6'

      alt-shift-1 = 'move-node-to-workspace 1'
      alt-shift-2 = 'move-node-to-workspace 2'
      alt-shift-3 = 'move-node-to-workspace 3'
      alt-shift-4 = 'move-node-to-workspace 4'
      alt-shift-5 = 'move-node-to-workspace 5'
      alt-shift-6 = 'move-node-to-workspace 6'

      alt-shift-r = 'reload-config'

      [workspace-to-monitor-force-assignment]
      1 = 'main'
      2 = 'main'
      3 = 'main'
      4 = 'main'
      5 = 'main'
      6 = 'main'

      # browser
      [[on-window-detected]]
      if.app-name-regex-substring = 'arc'
      run = 'move-node-to-workspace 1'

      # torrent
      [[on-window-detected]]
      if.app-name-regex-substring = 'qbittorrent'
      run = 'move-node-to-workspace 2'

      # code
      [[on-window-detected]]
      if.app-name-regex-substring = 'kitty'
      run = 'move-node-to-workspace 3'

      [[on-window-detected]]
      if.app-name-regex-substring = 'mail'
      run = 'move-node-to-workspace 4'

      [[on-window-detected]]
      if.app-name-regex-substring = 'telegram'
      run = 'move-node-to-workspace 4'

      [[on-window-detected]]
      if.app-name-regex-substring = 'vesktop'
      run = 'move-node-to-workspace 4'

      [[on-window-detected]]
      if.app-name-regex-substring = 'spotify'
      run = 'move-node-to-workspace 5'
    '';
  };
}
