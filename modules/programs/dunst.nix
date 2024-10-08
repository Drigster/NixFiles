{
  pkgs,
  config,
  ...
}: {
  services.dunst = {
    enable = true;
    settings = {
      global = {
        frame_width = 2;
        frame_color = "#788388";
        background = "#18181b";
        corner_radius = 4;
        icon_corner_radius = 4;

        font = "Fira Code Mono 10";

        markup = "yes";
        show_age_threshold = 60;

        transparency = 15;

        monitor = 0;
        follow = "none";
        origin = "top-right";
        offset = "6x6";

        separator_height = 1;

        icon_position = "left";
        icon_path = "/usr/share/icons/Adwaita/16x16/status/:/usr/share/icons/Adwaita/16x16/devices/";
        max_icon_size = 32;

        mouse_left_click = "do_action, close_current";
        mouse_middle_click = "context";
        mouse_right_click = "close_current";
        dmenu = "/usr/bin/rofi -dmenu -p dunst";
      };
    };
  };
}
