{...}: {
  imports = [
    ./waybar.nix
  ];

  wayland.windowManager.hyprland.enable = true;
  wayland.windowManager.hyprland.xwayland.enable = true;
  wayland.windowManager.hyprland.settings = {
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
      "DP-4, 2560x1080@144, 0x0, 1"
      "Unknown-1, disable"
    ];

    "$mod" = "SUPER";

    # Programs
    "$terminal" = "kitty";
    "$fileManager" = "thunar";
    "$menu" = "rofi -show drun -click-to-exit -kb-cancel \"Escape,MouseSecondary\"";
    "$browser" = "firefox";

    # Scripts
    "$workspace" = "bun /home/drigster/dotfiles/bin/scripts/src/workspaces.ts";

    # For all categories, see https://wiki.hyprland.org/Configuring/Variables/
    input = {
      kb_layout = "us, ru";
      kb_options = "grp:win_space_toggle";

      follow_mouse = 1;
      mouse_refocus = false;

      touchpad = {
        natural_scroll = "no";
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

      drop_shadow = "yes";
      shadow_range = 4;
      shadow_render_power = 3;
      "col.shadow" = "rgba(1a1a1aee)";
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

    # Window rules
    windowrulev2 = [
      "suppressevent maximize, class:.*"
      "center, class:^(Xdg-desktop-portal-gtk)\"$\""
      "stayfocused, class:^(Xdg-desktop-portal-gtk)\"$\""
      "center, floating:1,class:^(Code)\"$\""
      "stayfocused, floating:1,class:^(Code)\"$\""
      "float, class:^([Ss]team)\"$\", title:^((?![Ss]team).*)\"$\""
      "workspace 5 silent, class:^([Ss]team)\"$\", title:^([Ss]team)\"$\""
      "tile, class:^([Ss]team)\"$\", title:^([Ss]team)\"$\""
    ];

    windowrule = [
      "float, title:^(Picture-in-Picture)\"$\""
      "float, ^(file-roller)\"$\""
      "workspace 3 silent, firefox"
      "workspace 4 silent, discord"
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
      "$mod, D, exec, discord"
      "$mod, B, exec, $browser"
      "ALT, SPACE, exec, pkill rofi || $menu"
      "$mod, Q, killactive, "
      "$mod, M, exit, "
      "$mod, J, togglesplit, "
      "$mod SHIFT, F, fullscreen"
      "ALT, PRINT, exec, hyprshot --freeze -m region -o ~/Pictures/Screenshots/\"$\"(date + '%Y-%m') -f \"$\"(date + '%Y-%m-%d-%H:%M_region.png')"
      ", PRINT, exec, hyprshot -m output -c -o ~/Pictures/Screenshots/\"$\"(date + '%Y-%m') -f \"$\"(date + '%Y-%m-%d-%H:%M_screen.png')"
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
      "$mod SHIFT, 6, exec, $workspace switch 6"
      "$mod SHIFT, 7, exec, $workspace switch 7"
      "$mod SHIFT, 8, exec, $workspace switch 8"
      "$mod SHIFT, 9, exec, $workspace switch 9"
      "$mod SHIFT, left, exec, $workspace movemonitor"
      "$mod SHIFT, right, exec, $workspace movemonitor"
      "$mod, left, exec, $workspace switchmonitor"
      "$mod, right, exec, $workspace switchmonitor"
    ];

    workspace = [
      "1,monitor:DP-4"
      "2,monitor:DP-4"
      "3,monitor:DP-4"
      "4,monitor:DP-4"
      "5,monitor:DP-4"
      "6,monitor:DP-4"
      "7,monitor:DP-4"
      "8,monitor:DP-4"
      "9,monitor:DP-4"
      "special:special, on-created-empty:[float;size 50% 70%;center;animation slidefadevert -50%;stayfocused] kitty -o background_opacity=0.7"
    ];
    # Move/resize windows with mod + LMB/RMB and dragging
    bindm = [
      "$mod, mouse:272, movewindow"
      "$mod, mouse:273, resizewindow"
    ];
  };
}
