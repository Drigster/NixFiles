{
  pkgs,
  config,
  ...
}: {
  programs.rofi = {
    enable = true;
    package = pkgs.rofi-wayland;
    plugins = [
      pkgs.rofi-calc
      pkgs.rofi-power-menu
    ];
    theme = let
      inherit (config.lib.formats.rasi) mkLiteral;
    in {
      configuration = {
        # calc:${pkgs.rofi-calc}/bin/calc,
        modi = "drun,calc,filebrowser,window,combi,run,power-menu:${pkgs.rofi-power-menu}/bin/rofi-power-menu";
        combi-modi = ["drun" "calc" "power-menu"];
        show-icons = true;
        display-drun = "";
        drun-display-format = "{name}";
        window-format = "{w}{t}";
        font = "FiraCode Nerd Font Mono 15";
        icon-theme = "Tela-circle-dracula";
      };
      "*" = {
        main-bg = mkLiteral "#11111bc0";
        main-fg = mkLiteral "#f5f5f5ff";
        select-bg = mkLiteral "#b442ff80";
        border = mkLiteral "#b442ffff";
        select-fg = mkLiteral "transparent";
        border-color = mkLiteral "transparent";
      };
      window = {
        width = mkLiteral "37em";
        transparency = "real";
        fullscreen = false;
        enabled = true;
        cursor = "default";
        spacing = mkLiteral "0em";
        padding = mkLiteral "0em";
        border = mkLiteral "2px";
        border-color = mkLiteral "@border";
        background-color = mkLiteral "@main-bg";
        border-radius = mkLiteral "0.5em";
      };
      mainbox = {
        enabled = true;
        spacing = mkLiteral "0em";
        padding = mkLiteral "0em";
        orientation = mkLiteral "vertical";
        children = map mkLiteral ["inputbar" "listview"];
        background-color = mkLiteral "transparent";
      };
      inputbar = {
        enabled = true;
        spacing = mkLiteral "0.5em";
        padding = mkLiteral "0.5em 0.5em 0em 0.5em";
        children = map mkLiteral ["prompt" "entry"];
        background-color = mkLiteral "@main-bg";
      };
      prompt = {
        padding = mkLiteral "0 0.5em";
        background-color = mkLiteral "transparent";
        background-image = mkLiteral "url(\"/home/drigster/dotfiles/assets/profile-transparent.svg\", both)";
      };
      entry = {
        background-color = mkLiteral "transparent";
        text-color = mkLiteral "@main-fg";
      };
      listview = {
        padding = mkLiteral "1em";
        spacing = mkLiteral "0em";
        enabled = mkLiteral "true";
        columns = mkLiteral "1";
        lines = mkLiteral "10";
        cycle = true;
        dynamic = true;
        scrollbar = false;
        layout = mkLiteral "vertical";
        reverse = false;
        expand = false;
        fixed-height = true;
        fixed-columns = true;
        cursor = "default";
        background-color = mkLiteral "@main-bg";
        text-color = mkLiteral "@main-fg";
      };
      element = {
        enabled = true;
        spacing = mkLiteral "0.5em";
        padding = mkLiteral "0.2em";
        cursor = mkLiteral "pointer";
        background-color = mkLiteral "transparent";
        text-color = mkLiteral "@main-fg";
        border-color = mkLiteral "transparent";
        border = mkLiteral "2px";
        border-radius = mkLiteral "0.25em";
      };
      "element selected.normal" = {
        background-color = mkLiteral "@select-bg";
        border-color = mkLiteral "@border";
      };
      element-icon = {
        size = mkLiteral "1em";
        cursor = mkLiteral "inherit";
        background-color = mkLiteral "transparent";
        text-color = mkLiteral "inherit";
      };
      element-text = {
        vertical-align = mkLiteral "0.5";
        horizontal-align = mkLiteral "0.0";
        cursor = mkLiteral "inherit";
        background-color = mkLiteral "transparent";
        text-color = mkLiteral "inherit";
      };
    };
  };
}
