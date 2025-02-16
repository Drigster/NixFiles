{...}: {
  imports = [
    ./waybar.nix
  ];

  wayland.windowManager.hyprland = {
    # Whether to enable Hyprland wayland compositor
    enable = true;
    # Whether to enable XWayland
    xwayland.enable = true;

    # Optional
    # Whether to enable hyprland-session.target on hyprland startup
    systemd.enable = true;
    settings = {
      env = [
        "LIBVA_DRIVER_NAME,nvidia"
        "XDG_SESSION_TYPE,wayland"
        "GBM_BACKEND,nvidia-drm"
        "__GLX_VENDOR_LIBRARY_NAME,nvidia"
        "WLR_NO_HARDWARE_CURSORS,1"
        "XCURSOR_SIZE,22"
        "QT_QPA_PLATFORMTHEME,qt5ct"
        "QT_QPA_PLATFORMTHEME,qt6ct"
      ];

      monitor = [
        ", prefered, auto, 1"
      ];

      "$mod" = "SUPER";

      # Programs
      "$terminal" = "kitty";
      "$fileManager" = "nemo";
      "$menu" = "rofi -show combi -click-to-exit -kb-cancel \"Escape,MouseSecondary\"";
      "$browser" = "firefox";

      # Scripts
      "$workspace" = "bun /home/drigster/.config/scripts/workspaces.ts";

      # For all categories, see https://wiki.hyprland.org/Configuring/Variables/
      input = {
        kb_layout = "us, ru, ee";
        kb_options = "grp:win_space_toggle";

        follow_mouse = 1;
        mouse_refocus = false;

        touchpad = {
          natural_scroll = "no";
          disable_while_typing = "no";
        };
        sensitivity = 0;
      };

      general = {
        gaps_in = 2;
        gaps_out = 6;
        border_size = 2;
        "col.active_border" = "rgba(b442ffee) rgba(3633ffee) 45deg";
        "col.inactive_border" = "rgba(595959aa)";

        layout = "dwindle";
        allow_tearing = false;
      };

      decoration = {
        rounding = 4;

        blur = {
          enabled = true;
          size = 3;
          passes = 1;
        };

        # drop_shadow = "yes";
        # shadow_range = 4;
        # shadow_render_power = 3;
        # "col.shadow" = "rgba(1a1a1aee)";
      };

      animations = {
        enabled = "yes";

        # Some default animations, see https://wiki.hyprland.org/Configuring/Animations/ for more

        bezier = "myBezier, 0.05, 0.9, 0.1, 1.05";

        animation = [
          "windows, 1, 4, myBezier"
          "windowsOut, 1, 4, default, popin 80%"
          "border, 1, 3, default"
          "borderangle, 1, 8, default"
          "fade, 1, 3, default"
          "workspaces, 1, 2, default"
          "specialWorkspace, 1, 6, default, slidefadevert -50%"
        ];
      };
      dwindle = {
        pseudotile = "yes";
        preserve_split = "yes";
      };

      source = ["~/.config/hypr/HyprlandUnityFix/UnityFix.conf"];

      # Window rules
      windowrulev2 = [
        "suppressevent maximize, class:.*"
        "center, class:^(Xdg-desktop-portal-gtk)$"
        "stayfocused, class:^(Xdg-desktop-portal-gtk)$"
        "workspace 9, class:^(Spotify)$"
        "tile, class:^.*([mM]inecraft).*$"
        "float, class:^pro\.gravit\.launcher.*$"
        "center, class:^pro\.gravit\.launcher.*$"
        # "minsize 300 150, class:^Unity$"

        #VSCode
        "center, floating:1,class:^(Code)$"
        "stayfocused, floating:1,class:^(Code)$"

        #Steam
        "workspace 5 silent, class:^([Ss]team)$, title:^([Ss]team)$"
        "float, class:^([Ss]team)$, title:^((?![Ss]team).*)$"
        "tile, class:^([Ss]team)$, title:^([Ss]team)$"
        "workspace 1, class:^(steam_app_(.*))$"
        "fullscreen, class:^(steam_app_(.*))$"
        "workspace 1, class:^(factorio)$"
        "fullscreen, class:^(factorio)$"

        #VirtualBox
        "workspace 2 silent,class:^(VirtualBoxVM)$"
        "stayfocused, title:^(VirtualBox Manager)$, class:^(VirtualBox Manager)$"
        "size 1060 630,class:^(VirtualBox)$,title:^(.*Preferences*.)$"
        "center,class:^(VirtualBox)$,title:^(.*Preferences*.)$"
        "float,class:^(VirtualBox)$,title:^(.*Preferences*.)$"
        "size 1060 630,class:^(VirtualBox)$,title:^(.*Settings*.)$"
        "center,class:^(VirtualBox)$,title:^(.*Settings*.)$"
        "float,class:^(VirtualBox)$,title:^(.*Settings*.)$"
        "size 1060 630,class:^(VirtualBox)$,title:^(.* - *.)$"
        "center,class:^(VirtualBox)$,title:^(.* - *.)$"
        "float,class:^(VirtualBox)$,title:^(.* - *.)$"
        "fullscreen,class:^(VirtualBoxVM)$"
      ];

      windowrule = [
        "float, title:^(Picture-in-Picture)$"
        "float, ^(file-roller)$"
        "workspace 3 silent, firefox"
        "workspace 4 silent, vesktop"
        "float, xfce-polkit"
        "maxsize 410 150, xfce-polkit"
        "minsize 410 150, xfce-polkit"
        "stayfocused, xfce-polkit"
      ];

      # Example binds, see https://wiki.hyprland.org/Configuring/Binds/ for more
      bind = [
        "$mod, T, exec, $terminal"
        "$mod, Return, togglespecialworkspace"
        "$mod, E, exec, $fileManager"
        "$mod, D, exec, vesktop"
        "$mod, C, exec, codium --enable-features=UseOzonePlatform --ozone-platform=wayland"
        "$mod, B, exec, $browser"
        "ALT, SPACE, exec, pkill rofi || $menu"
        "$mod, Q, killactive, "
        "$mod, M, exit, "
        "$mod, J, togglesplit, "
        "$mod SHIFT, F, fullscreen"
        "CTRL, PRINT, exec, hyprshot --freeze -m region -o ~/Pictures/Screenshots/$(date + '%Y-%m') -f $(date + '%Y-%m-%d-%H:%M_region.png')"
        ", PRINT, exec, hyprshot -m output -o ~/Pictures/Screenshots/$(date + '%Y-%m') -f $(date + '%Y-%m-%d-%H:%M_screen.png')"
        "$mod, 1, exec, $workspace switch 1"
        "$mod, 2, exec, $workspace switch 2"
        "$mod, 3, exec, $workspace switch 3"
        "$mod, 4, exec, $workspace switch 4"
        "$mod, 5, exec, $workspace switch 5"
        "$mod, 6, exec, $workspace switch 6"
        "$mod, 7, exec, $workspace switch 7"
        "$mod, 8, exec, $workspace switch 8"
        "$mod, 9, exec, $workspace switch 9"
        "$mod SHIFT, 1, exec, $workspace move 1"
        "$mod SHIFT, 2, exec, $workspace move 2"
        "$mod SHIFT, 3, exec, $workspace move 3"
        "$mod SHIFT, 4, exec, $workspace move 4"
        "$mod SHIFT, 5, exec, $workspace move 5"
        "$mod SHIFT, 6, exec, $workspace move 6"
        "$mod SHIFT, 7, exec, $workspace move 7"
        "$mod SHIFT, 8, exec, $workspace move 8"
        "$mod SHIFT, 9, exec, $workspace move 9"
        "$mod SHIFT, left, exec, $workspace movemonitor"
        "$mod SHIFT, right, exec, $workspace movemonitor"
        "$mod, left, exec, $workspace switchmonitor"
        "$mod, right, exec, $workspace switchmonitor"

        ", XF86AudioMute, exec, wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"
        ", XF86AudioRaiseVolume, exec, wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%+"
        ", XF86AudioLowerVolume, exec, wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-"
        ", XF86AudioNext, exec, bun /home/drigster/dotfiles/bin/scripts/src/media/actions.ts next"
        ", XF86AudioPrev, exec, bun /home/drigster/dotfiles/bin/scripts/src/media/actions.ts previous"
        ", XF86AudioPlay, exec, bun /home/drigster/dotfiles/bin/scripts/src/media/actions.ts playpause"
        ", XF86MonBrightnessDown, exec, "
        ", XF86MonBrightnessUp, exec, "
        ", XF86Tools, exec, rofi -show combi -click-to-exit -kb-cancel \"Escape,MouseSecondary\""
      ];

      workspace = [
        "1,monitor:HDMI-A-2"
        "2,monitor:HDMI-A-2"
        "3,monitor:HDMI-A-2"
        "4,monitor:HDMI-A-2"
        "5,monitor:HDMI-A-2"
        "6,monitor:HDMI-A-2"
        "7,monitor:HDMI-A-2"
        "8,monitor:HDMI-A-2"
        "9,monitor:HDMI-A-2"
        "1,monitor:DP-4"
        "2,monitor:DP-4"
        "3,monitor:DP-4"
        "4,monitor:DP-4"
        "5,monitor:DP-4"
        "6,monitor:DP-4"
        "7,monitor:DP-4"
        "8,monitor:DP-4"
        "9,monitor:DP-4"
        "1,monitor:eDP-1"
        "2,monitor:eDP-1"
        "3,monitor:eDP-1"
        "4,monitor:eDP-1"
        "5,monitor:eDP-1"
        "6,monitor:eDP-1"
        "7,monitor:eDP-1"
        "8,monitor:eDP-1"
        "9,monitor:eDP-1"
        "special:special, on-created-empty:[float;size 50% 70%;center;animation slidefadevert -50%;stayfocused] kitty -o background_opacity=0.7"
      ];
      # Move/resize windows with mod + LMB/RMB and dragging
      bindm = [
        "$mod, mouse:272, movewindow"
        "$mod, mouse:273, resizewindow"
      ];

      exec-once = [
        "polkit-agent-helper-1"
        "systemctl start --user polkit-gnome-authentication-agent-1 >>~/pw-link.log 2>&1"
        "SOURCE_PORT=\"Game\"; DESTINATION_PORT=\"alsa_output.pci-0000_0c_00.6.analog-stereo\"; while ! (pw-cli ls | grep \"$SOURCE_PORT\" && pw-cli ls | grep \"$DESTINATION_PORT\"); do sleep 1; done; pw-link \"$SOURCE_PORT\" \"$DESTINATION_PORT\" >>~/pw-link.log 2>&1"
        "SOURCE_PORT=\"Chat\"; DESTINATION_PORT=\"alsa_output.pci-0000_0c_00.6.analog-stereo\"; while ! (pw-cli ls | grep \"$SOURCE_PORT\" && pw-cli ls | grep \"$DESTINATION_PORT\"); do sleep 1; done; pw-link \"$SOURCE_PORT\" \"$DESTINATION_PORT\" >>~/pw-link.log 2>&1"
        "SOURCE_PORT=\"Media\"; DESTINATION_PORT=\"alsa_output.pci-0000_0c_00.6.analog-stereo\"; while ! (pw-cli ls | grep \"$SOURCE_PORT\" && pw-cli ls | grep \"$DESTINATION_PORT\"); do sleep 1; done; pw-link \"$SOURCE_PORT\" \"$DESTINATION_PORT\" >>~/pw-link.log 2>&1"
        "SOURCE_PORT=\"alsa_input.usb-C-Media_Electronics_Inc._GXT_258_Microphone-00.analog-stereo\"; DESTINATION_PORT=\"Mic\"; while ! (pw-cli ls | grep \"$SOURCE_PORT\" && pw-cli ls | grep \"$DESTINATION_PORT\"); do sleep 1; done; pw-link \"$SOURCE_PORT\" \"$DESTINATION_PORT\" >>~/pw-link.log 2>&1"
        "export LD_LIBRARY_PATH=$(nix build --print-out-paths --no-link nixpkgs#libGL)/lib"
        "syncthing --no-browser"
      ];
    };
  };
}
