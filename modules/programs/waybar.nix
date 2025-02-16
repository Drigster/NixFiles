{...}: {
  programs.waybar = {
    enable = true;
    systemd.enable = true;
    settings = {
      mainBar = {
        layer = "top";
        height = 30;
        spacing = 6;

        modules-left = ["hyprland/workspaces" "custom/media"];
        modules-center = ["clock"];
        modules-right = [
          "tray"
          "hyprland/language"
          "network"
          "bluetooth"
          "backlight"
          "battery"
          "cpu"
          "custom/gpu"
          "memory"
          "pulseaudio"
          "pulseaudio#pulse2"
          "custom/power"
        ];
        "hyprland/window" = {
          max-length = 200;
          separate-outputs = true;
        };
        "hyprland/language" = {
          format = "{}";
          format-en = "us";
          format-ru = "ru";
          format-et = "et";
          on-scroll-down = "hyprctl switchxkblayout mountain-mountain-everest-keyboard next";
          on-scroll-up = "hyprctl switchxkblayout mountain-mountain-everest-keyboard prev";
          on-click-right = "sh /home/drigster/.config/scripts/switch_layouts.sh";
        };
        bluetooth = {
          format = "";
          format-on = "󰂯";
          format-off = "󰂲";
          format-connected = "󰂱";
          format-connected-battery = "󰂱";
          tooltip-format = "{controller_alias}\n\n";
          tooltip-format-connected = "{controller_alias}\n\n{num_connections} connected\n\n{device_enumerate}";
          tooltip-format-enumerate-connected = "{device_alias}";
          tooltip-format-enumerate-connected-battery = "{device_alias}\t{device_battery_percentage}%󰂄";
          on-click = "blueman-manager";
          on-right-click = "blueman-manager";
        };
        network = {
          format = "{ifname}";
          format-wifi = "󰖩";
          format-ethernet = "";
          format-disconnected = "󱘖";
          tooltip-format = "{ifname}";
          tooltip-format-wifi = "{essid} ({signalStrength}%) \n\n {bandwidthUpBytes}  {bandwidthDownBytes}";
          tooltip-format-ethernet = "{ifname}\n{ipaddr}";
          tooltip-format-disconnected = "Disconnected";
          interval = 5;
        };
        "hyprland/workspaces" = {
          format = "{icon}";
          on-scroll-up = "bun /home/drigster/.config/scripts/workspaces.ts previous";
          on-scroll-down = "bun /home/drigster/.config/scripts/workspaces.ts next";
          sort-by = "id";
          format-icons = {
            "1" = "1";
            "2" = "2";
            "3" = "";
            "4" = "";
            "5" = "5";
            "6" = "6";
            "7" = "7";
            "8" = "8";
            "9" = "";
          };
        };
        "wlr/taskbar" = {
          format = "{icon}";
          icon-size = 14;
          icon-theme = "Tela-circle-dracula";
          tooltip-format = "{title}";
          on-click = "minimize-raise";
          on-click-middle = "close";
          ignore-list = ["Alacritty"];
          app_ids-mapping = {
            firefoxdeveloperedition = "firefox-developer-edition";
          };
          rewrite = {
            "Firefox Web Browser" = "Firefox";
            "Visual Studio Code" = "Code";
          };
        };
        tray = {
          spacing = 10;
          show-passive-items = true;
        };
        clock = {
          interval = 1;
          format = "{:%H:%M:%S}";
          tooltip-format = "<tt><small>{calendar}</small></tt>";
          calendar = {
            mode = "month";
            on-scroll = 1;
            format = {
              months = "<span color='#ffead3'><b>{}</b></span>";
              days = "<span color='#ecc6d9'><b>{}</b></span>";
              weeks = "<span color='#99ffdd'><b>W{}</b></span>";
              weekdays = "<span color='#ffcc66'><b>{}</b></span>";
              today = "<span color='#ff6699'><b><u>{}</u></b></span>";
            };
          };
          actions = {
            on-scroll-up = "shift_down";
            on-scroll-down = "shift_up";
          };
          on-click = "killall --quiet /home/drigster/dotfiles/bin/galendae || /home/drigster/dotfiles/bin/galendae";
        };
        cpu = {
          format = " {usage}%";
          states = {
            warning = 80;
            critical = 90;
          };
          on-click = "kitty btop";
          interval = 5;
        };
        memory = {
          format = " {used:0.1f}GB";
          tooltip-format = "{used:0.1f}GB / {total:0.1f}GB";
          states = {
            warning = 80;
            critical = 90;
          };
          on-click = "kitty btop";
          interval = 5;
        };
        "custom/gpu" = {
          exec = "cat /sys/class/hwmon/hwmon2/device/gpu_busy_percent";
          format = "GPU: {}%";
          interval = 5;
        };
        backlight = {
          format = "{icon} {percent}%";
          format-icons = ["󰹐" "󱩎" "󱩏" "󱩐" "󱩑" "󱩒" "󱩓" "󱩔" "󱩕" "󱩖" "󰛨"];
          on-scroll-up = "brightnessctl set +5%";
          on-scroll-down = "brightnessctl set 5%-";
        };
        battery = {
          interval = 5;
          states = {
            "0" = 0;
            "10" = 10;
            "20" = 20;
            "30" = 30;
            "40" = 40;
            "50" = 50;
            "60" = 60;
            "70" = 70;
            "80" = 80;
            "90" = 90;
            "100" = 100;
          };
          format-0 = "󰂎 {capacity}%";
          format-10 = "󰁺 {capacity}%";
          format-20 = "󰁻 {capacity}%";
          format-30 = "󰁼 {capacity}%";
          format-40 = "󰁽 {capacity}%";
          format-50 = "󰁾 {capacity}%";
          format-60 = "󰁿 {capacity}%";
          format-70 = "󰂀 {capacity}%";
          format-80 = "󰂁 {capacity}%";
          format-90 = "󰂂 {capacity}%";
          format-100 = "󰁹 {capacity}%";
          format-charging-0 = "󰢟 {capacity}%";
          format-charging-10 = "󰢜 {capacity}%";
          format-charging-20 = "󰂆 {capacity}%";
          format-charging-30 = "󰂇 {capacity}%";
          format-charging-40 = "󰂈 {capacity}%";
          format-charging-50 = "󰢝 {capacity}%";
          format-charging-60 = "󰂉 {capacity}%";
          format-charging-70 = "󰢞 {capacity}%";
          format-charging-80 = "󰂊 {capacity}%";
          format-charging-90 = "󰂋 {capacity}%";
          format-charging-100 = "󰂅 {capacity}%";
          max-length = 25;
        };
        pulseaudio = {
          format = "{icon} {volume}%";
          format-muted = "󰝟 {volume}%";
          format-icons = {
            "default" = ["󰕿" "󰖀" "󰕾"];
          };
          on-scroll-up = "wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%+";
          on-scroll-down = "wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-";
          on-click = "wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle";
          on-click-right = "pavucontrol";
        };
        "pulseaudio#pulse2" = {
          scroll-step = 5;
          format = "{format_source}";
          format-muted = "{format_source}";
          format-source = "󰍬 {volume}%";
          format-source-muted = "󰍭 {volume}%";
          on-scroll-up = "wpctl set-volume @DEFAULT_AUDIO_SOURCE@ 5%+";
          on-scroll-down = "wpctl set-volume @DEFAULT_AUDIO_SOURCE@ 5%-";
          on-click = "wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle";
          on-click-right = "pavucontrol";
          tooltip = "false";
        };
        "custom/power" = {
          format = "";
          on-click = "rofi -show power-menu -modi power-menu:rofi-power-menu -click-to-exit -kb-cancel \"Escape,MouseSecondary\"";
        };
        "custom/media" = {
          exec = "bun /home/drigster/dotfiles/bin/scripts/src/media/display.ts";
          on-click = "bun /home/drigster/dotfiles/bin/scripts/src/media/actions.ts playpause";
          restart-interval = 120;
          smooth-scrolling-threshold = 0;
          on-scroll-down = "bun /home/drigster/dotfiles/bin/scripts/src/media/actions.ts next";
          on-click-right = "bun /home/drigster/dotfiles/bin/scripts/src/media/actions.ts next";
          on-scroll-up = "bun /home/drigster/dotfiles/bin/scripts/src/media/actions.ts previous";
          return-type = "json";
        };
      };
    };
    style = ''
      * {
        font-family: "Symbols Nerd Font Mono", "FiraCode Nerd Font Mono";
        font-size: 14px;
      }

      window#waybar {
        background-color: rgba(0, 0, 0, 0);
        color: #ffffff;
        transition-property: background-color;
        transition-duration: 0.5s;
      }

      window#waybar.hidden {
        opacity: 0.2;
      }

      button {

      }

      button:hover {
        background: inherit;
      }

      #workspaces {
        background-color: #091a27;
        border-radius: 16px;
        margin-left: 6px;
      }

      #workspaces button {
        background-color: transparent;
        color: #999;
      }

      #workspaces button:hover {

      }

      #workspaces button.active {
        color: #ffffff;
      }

      #workspaces button.urgent {
        color: #eb4d4b;
      }

      .module {
        margin-top: 6px;
      }

      .module:not(#workspaces) {
        background-color: #091a27;
        padding: 0 10px;
        color: #999;
        border-radius: 16px;
      }

      .warning {
        animation: blink 0.4s linear infinite alternate;
      }

      .critical,
      .disconnected {
        animation: red-blink 0.4s linear infinite alternate;
      }

      #clock {

      }

      #memory {

      }

      #cpu {

      }

      #network {

      }

      #pulseaudio {

      }

      #custom-media {

      }

      #custom-power {
        margin-right: 6px;
      }

      #tray > .passive {
        -gtk-icon-effect: dim;
      }

      #tray > .needs-attention {
        -gtk-icon-effect: highlight;
        background-color: #eb4d4b;
      }

      @keyframes red-blink {
        to {
          background-color: #b91c1c;
          color: #fff;
        }
      }

      @keyframes blink {
        to {
          background-color: #eab308;
          color: #000000;
        }
      }
    '';
  };
}
