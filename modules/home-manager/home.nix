{
  config,
  pkgs,
  ...
}: {
  imports = [
    ./../programs/hyprland.nix
    ./../programs/rofi.nix
    ./../programs/dunst.nix
  ];
  # Home Manager needs a bit of information about you and the paths it should
  # manage.
  home.username = "drigster";
  home.homeDirectory = "/home/drigster";

  # This value determines the Home Manager release that your configuration is
  # compatible with. This helps avoid breakage when a new Home Manager release
  # introduces backwards incompatible changes.
  #
  # You should not change this value, even if you update Home Manager. If you do
  # want to update the value, then make sure to first check the Home Manager
  # release notes.
  home.stateVersion = "24.05"; # Please read the comment before changing.

  # The home.packages option allows you to install Nix packages into your
  # environment.
  home.packages = [
    pkgs.sublime4
    pkgs.thunderbird
    pkgs.vesktop # discord
    pkgs.rustup
    pkgs.vscodium-fhs
    pkgs.spotify
    pkgs.syncthing
    pkgs.python3

    pkgs.libqalculate
    pkgs.rofi-calc
    pkgs.rofi-power-menu
    pkgs.xorg.xev

    pkgs.vlc
    pkgs.sqlitebrowser
    pkgs.nfs-utils
    pkgs.mongodb-compass
    pkgs.jetbrains.jdk
    pkgs.davinci-resolve-studio
    pkgs.teamspeak5_client

    pkgs.prismlauncher
    pkgs.telegram-desktop

    # # It is sometimes useful to fine-tune packages, for example, by applying
    # # overrides. You can do that directly here, just don't forget the
    # # parentheses. Maybe you want to install Nerd Fonts with a limited number of
    # # fonts?
    # (pkgs.nerdfonts.override { fonts = [ "FantasqueSansMono" ]; })

    # # You can also create simple shell scripts directly inside your
    # # configuration. For example, this adds a command 'my-hello' to your
    # # environment:
    # (pkgs.writeShellScriptBin "my-hello" ''
    #   echo "Hello, ${config.home.username}!"
    # '')
  ];

  # Home Manager is pretty good at managing dotfiles. The primary way to manage
  # plain files is through 'home.file'.
  home.file = {
    # # Building this configuration will create a copy of 'dotfiles/screenrc' in
    # # the Nix store. Activating the configuration will then make '~/.screenrc' a
    # # symlink to the Nix store copy.
    # ".screenrc".source = dotfiles/screenrc;

    # # You can also set the file content immediately.
    # ".gradle/gradle.properties".text = ''
    #   org.gradle.console=verbose
    #   org.gradle.daemon.idletimeout=3600000
    # '';
  };

  # Home Manager can also manage your environment variables through
  # 'home.sessionVariables'. These will be explicitly sourced when using a
  # shell provided by Home Manager. If you don't want to manage your shell
  # through Home Manager then you have to manually source 'hm-session-vars.sh'
  # located at either
  #
  #  ~/.nix-profile/etc/profile.d/hm-session-vars.sh
  #
  # or
  #
  #  ~/.local/state/nix/profiles/profile/etc/profile.d/hm-session-vars.sh
  #
  # or
  #
  #  /etc/profiles/per-user/drigster/etc/profile.d/hm-session-vars.sh
  #
  home.sessionVariables = {
    EDITOR = "subl";
  };

  gtk = {
    enable = true;
    font.name = "FiraCode Nerd Font Mono";
    theme.name = "adw-gtk3-dark";
  };

  xdg.mimeApps.defaultApplications = {
    "inode/directory" = ["nemo.desktop" "codium.desktop"];
    "image/jpeg" = ["gimp.desktop"];
    "text/plain" = ["codium.desktop"];
    "image/svg+xml" = ["codium.desktop"];
    "application/x-shellscript" = ["sublime_text.desktop" "kitty-open.desktop" "okularApplication_txt.desktop"];
  };

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
  programs.git = {
    enable = true;
    userName = "Drigster";
    userEmail = "62962772+Drigster@users.noreply.github.com";
    extraConfig = {
      pull.rebase = true;
    };
  };

  programs.obs-studio = {
    enable = true;
    plugins = with pkgs.obs-studio-plugins; [
      wlrobs
      obs-backgroundremoval
      obs-pipewire-audio-capture
    ];
  };

  programs.fish.enable = true;
}
