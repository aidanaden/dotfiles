{
  config,
  lib,
  pkgs,
  ...
}: {
  programs.waybar = {
    enable = true;
    systemd = {
      enable = true;
      target = "graphical-session.target";
    };
    style = ''
      * {
        /* `otf-font-awesome` is required to be installed for icons */
        font-family: "MesloLGS Nerd Font Mono";
        font-size: 11pt;
        font-weight: 900;
        transition-property: background-color;
        transition-duration: 0.5s;
        padding: 0px;
        margin:0px;
        border-radius: 3px;

      }

      /* Reset all styles */
      * {
          border: none;
          border-radius: 3px;
          min-height: 0;
          margin: 0.2em 0.3em 0.2em 0.3em;
      }

      /* The whole bar */
      #waybar {
          background-color: rgba(26, 27, 38, 0.8);
          color: #414868;
          transition-property: background-color;
          transition-duration: 0.5s;
          border-top: 3px transparent;
          border-radius: 3px;
          margin: 0px 0px;
      }

      window#waybar.hidden {
        opacity: 0.2;
      }

      #workspaces button {
        padding: 0 0px;
        color: #A9B1D6;
        background-color: transparent;
        /* Use box-shadow instead of border so the text isn't offset */
        box-shadow: inset 0 3px transparent;
        /* Avoid rounded borders under each workspace name */
        border: none;
        border-radius: 0;
      }

      #workspaces button.focused {
        background-color: transparent;
      }
      #workspace button.hover {
        background-color: transparent;
      }
      #workspaces button.active {
        color: #9ECE6A;
      }

      #workspaces button.urgent {
        color: #F7768E;
      }

      #window {
        /* border-radius: 20px; */
        /* padding-left: 10px; */
        /* padding-right: 10px; */
        color: #9ECE6A;
      }

      /* Each module */
      #clock,
      #battery,
      #cpu,
      #memory,
      #disk,
      #temperature,
      #backlight,
      #network,
      #pulseaudio,
      #wireplumber,
      #custom-media,
      #custom_screenshot,
      #tray,
      #mode,
      #idle_inhibitor,
      #mpd,
      #bluetooth,
      #custom-hyprPicker,
      #custom-power,
      #custom-spotify,
      #custom-weather,
      #custom-weather.severe,
      #custom-weather.sunnyDay,
      #custom-weather.clearNight,
      #custom-weather.cloudyFoggyDay,
      #custom-weather.cloudyFoggyNight,
      #custom-weather.rainyDay,
      #custom-weather.rainyNight,
      #custom-weather.showyIcyDay,
      #custom-weather.snowyIcyNight,
      #custom-weather.default,
      #custom-rofi,
      #custom-notification {
        padding: 0px 11px;
        color: #E0AF68;
        border-radius: 20px;
        background-color: rgba(26, 27, 38, 0);
      }

      #window,
      #workspaces {
        border-radius: 20px;
        padding: 0px 10px;
        background-color: #414868;
      }

      #custom-wallpaper {
        color: #7AA2F7;
        background-color: rgba(26, 27, 38, 0);
        padding: 0px 10px;
        border-radius: 20px;
      }

      #cpu {
        background-color: #F7768E;
        color: #15161E;
        padding: 0px 0px;
      }

      #memory {
        background-color: #9ECE6A;
        color: #15161E;
      }

      #custom-power {
        background-color: rgba(26, 27, 38, 0);
        color: #F7768E;
      }


      #custom-rofi {
        background-color: rgba(20, 27, 30, 0.0);
        color:#83A598;
        font-size: 15px;
        background-image: url("/home/cjg/Downloads/archLogo.png");
        background-size: 30px 30px;
        background-repeat: no-repeat;
        background-position: center;
      }

      tooltip,
      #clock.calendar,
      #clock tooltip,
      #clock > tooltip,
      #clock {
          background: rgba(59, 66, 68, 0.8);
      }

      #custom-weather {
        color: #C0CAF5;
        background-color: #414868;
      }

      #custom-weather.severe {
        color: #eb937d;
      }

      #custom-weather.sunnyDay {
        color: #c2ca76;
      }

      #custom-weather.clearNight {
        color: #cad3f5;
        background-color: #414868;
      }

      #custom-weather.cloudyFoggyDay,
      #custom-weather.cloudyFoggyNight {
        color: #c2ddda;
        background-color: #414868;
      }

      #custom-weather.rainyDay,
      #custom-weather.rainyNight {
        color: #5aaca5;
        background-color: #414868;
      }

      #custom-weather.showyIcyDay,
      #custom-weather.snowyIcyNight {
        color: #d6e7e5;
        background-color: #414868;
      }

      #custom-weather.default {
        color: #FBF1C7;
        background-color: #414868;
      }

      /* If workspaces is the leftmost module, omit left margin */
      .modules-left > widget:first-child > #workspaces {
        margin-left: 0;
      }

      /* If workspaces is the rightmost module, omit right margin */
      .modules-right > widget:last-child > #workspaces {
        margin-right: 0;
      }

      #pulseaudio {
        color: #7d9bba;
      }

      #backlight {
        /* color: #EBCB8B; */
        color: #282828;
       /*background-color: #8fbcbb*/
         background-color: #2f88ff
      }

      #clock {
        color: #C0CAF5;
        background-color: #414868;
      }

      #battery {
        /*color: #c0caf5;*/
         background-color: #414868;
         color: #C0CAF5
      }

      #battery.charging,
      #battery.full,
      #battery.plugged {
        color: #282828;
        background-color: #B8BB26;
        animation-name: slide;
        animation-duration: 5s;
        animation-timing-function: ease;
        animation-iteration-count: infinite;
        animation-direction: alternate;
      }

      @keyframes slide {
        to {
          background-color: #414868;
          color: #FBF1C7;
        }
      }

      @keyframes blink {
        to {
          background-color: rgba(30, 34, 42, 0.5);
          color: #abb2bf;
        }
      }

      #battery.critical:not(.charging) {
        /*color: #f53c3c; */
        background-color: #f53c3c;
        color:#282828;
        animation-name: blink;
        animation-duration: 0.5s;
        animation-timing-function: linear;
        animation-iteration-count: infinite;
        animation-direction: alternate;
      }

      label:focus {
        background-color: #000000;
      }

      #custom-storage {
        background-color: #E0AF68;
        color: #15161E;
        padding: 10px 10px;
        border-radius: 20px;
      }

      #custom-pacman {
        background-color: #414868;
        color: #C0CAF5;
        padding-left: 10px;
        padding-right: 8px;
        border-radius: 20px;
      }

      #bluetooth {
        color: #707d9d;
      }

      #bluetooth.disconnected {
        color: #f53c3c;
      }

      #network {
        background-color: #BB9AF7;
        color: #15161E;
      }

      #network.disconnected {
       background-color: #f53c3c;
       color: #282828;
      }

      #custom-media {
        background-color: #414868;
        color: #C0CAF5;
        min-width: 100px;
      }

      #custom-media.custom-spotify {
        color: #8ccf7e;
        background-color: #414868;
      }

      #custom-media.custom-vlc {
        background-color: #ffa000;
      }

      #temperature {
        background-color: #7AA2F7;
        color: #15161E;
      }

      #temperature.critical {
        background-color: #eb4d4b;
      }

      #tray {
        background-color: #414868;
      }

      #tray > .passive {
       -gtk-icon-effect: dim;
      }

      #tray > .needs-attention {
        -gtk-icon-effect: highlight;
        background-color: #eb4d4b;
      }

      #custom-color {
        background-color: #414868;
        color: #D79921;
        padding-left: 10px;
        padding-right: 15px;
        border-radius: 3px;
      }

      #backlight {
        background-color: #414868;
        color: #FBF1C7;
      }

      #idle_inhibitor {
        background-color: #414868;
        color: #FBF1C7;
      }

      #idle_inhibitor.activated {
        background-color: #FBF1C7;
        color: #2d3436;
      }

      #language {
        background: #00b093;
        color: #740864;
        padding: 0 0px;
        margin: 0 5px;
        min-width: 16px;
      }

      #keyboard-state {
        background: #97e1ad;
        color: #000000;
        padding: 0 0px;
        margin: 0 5px;
        min-width: 16px;
      }

      #keyboard-state > label {
        padding: 0 0px;
      }

      #keyboard-state > label.locked {
        background: rgba(0, 0, 0, 0.2);
      }


      #wireplumber{
      background-color: #7DCFFF;
      color: #15161E;
      }
      #custom-screenshot{
      background-color: #414868;
      color: #FBF1C7;
      padding-left: 10px;
      padding-right: 15px;

      }

      window#waybar .horizontal{
      padding:1px;
      }
      window#waybar {
      border-radius: 10px;
      border: 2px solid #A9B1D6;
      }
      #custom-thunar{
      /*background-color: #414868;*/
      color: #e5c76b;
      padding-left: 10px;
      padding-right: 15px;
      }
      #custom-firefox{
      /*background-color: #414868;*/
      color: #fab387;
      padding-left: 10px;                                                                               padding-right: 15px
      }
      #custom-spotify{
      /*background-color: #232a2d;*/
      color: #8ccf7e;
      padding-left: 10px;                                                                               padding-right: 15px
      }
    '';
    settings = [
      {
        "layer" = "top";
        "position" = "top";
        modules-left = [
          "custom/launcher"
          "temperature"
          "mpd"
          "custom/cava-internal"
        ];
        modules-center = [
          "clock"
        ];
        modules-right = [
          "pulseaudio"
          "backlight"
          "memory"
          "cpu"
          "network"
          "custom/powermenu"
          "tray"
        ];
        "custom/launcher" = {
          "format" = " ";
          "on-click" = "pkill rofi || rofi2";
          "on-click-middle" = "exec default_wall";
          "on-click-right" = "exec wallpaper_random";
          "tooltip" = false;
        };
        "custom/cava-internal" = {
          "exec" = "sleep 1s && cava-internal";
          "tooltip" = false;
        };
        "pulseaudio" = {
          "scroll-step" = 1;
          "format" = "{icon} {volume}%";
          "format-muted" = "󰖁 Muted";
          "format-icons" = {
            "default" = ["" "" ""];
          };
          "on-click" = "pamixer -t";
          "tooltip" = false;
        };
        "clock" = {
          "interval" = 1;
          "format" = "{:%I:%M %p  %A %b %d}";
          "tooltip" = true;
          "tooltip-format" = "{=%A; %d %B %Y}\n<tt>{calendar}</tt>";
        };
        "memory" = {
          "interval" = 1;
          "format" = "󰻠 {percentage}%";
          "states" = {
            "warning" = 85;
          };
        };
        "cpu" = {
          "interval" = 1;
          "format" = "󰍛 {usage}%";
        };
        "mpd" = {
          "max-length" = 25;
          "format" = "<span foreground='#bb9af7'></span> {title}";
          "format-paused" = " {title}";
          "format-stopped" = "<span foreground='#bb9af7'></span>";
          "format-disconnected" = "";
          "on-click" = "mpc --quiet toggle";
          "on-click-right" = "mpc update; mpc ls | mpc add";
          "on-click-middle" = "kitty --class='ncmpcpp' ncmpcpp ";
          "on-scroll-up" = "mpc --quiet prev";
          "on-scroll-down" = "mpc --quiet next";
          "smooth-scrolling-threshold" = 5;
          "tooltip-format" = "{title} - {artist} ({elapsedTime:%M:%S}/{totalTime:%H:%M:%S})";
        };
        "network" = {
          "format-disconnected" = "󰯡 Disconnected";
          "format-ethernet" = "󰒢 Connected!";
          "format-linked" = "󰖪 {essid} (No IP)";
          "format-wifi" = "󰖩 {essid}";
          "interval" = 1;
          "tooltip" = false;
        };
        "custom/powermenu" = {
          "format" = "";
          "on-click" = "pkill rofi || ~/.config/rofi/powermenu/type-3/powermenu.sh";
          "tooltip" = false;
        };
        "tray" = {
          "icon-size" = 15;
          "spacing" = 5;
        };
      }
    ];
  };
}
