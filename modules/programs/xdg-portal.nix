{
  pkgs,
  lib,
  config,
  ...
}: {
  environment.pathsToLink = ["/share/xdg-desktop-portal" "/share/applications"];
  xdg.portal = {
    enable = true;
    config = {
      hyprland = {
        default = [
          "hyprland"
          "gtk"
        ];
      };
    };
    extraPortals = [
      pkgs.xdg-desktop-portal-gtk
      pkgs.xdg-desktop-portal-hyprland
    ];
  };
}
