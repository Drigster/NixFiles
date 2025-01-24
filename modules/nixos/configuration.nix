{
  config,
  pkgs,
  pkgsUnstable,
  inputs,
  lib,
  ...
}: {
  imports = [
    inputs.home-manager.nixosModules.default
    ./../programs/xdg-portal.nix
  ];

  _module.args.pkgsUnstable = import inputs.nixpkgs-unstable {
    inherit (pkgs.stdenv.hostPlatform) system;
    inherit (config.nixpkgs) config;
  };

  boot.loader.grub.enable = true;
  boot.loader.grub.device = "nodev";
  boot.loader.grub.useOSProber = true;
  boot.loader.grub.efiSupport = true;
  boot.loader.efi.canTouchEfiVariables = true;

  networking.hostName = "nixos";

  networking.networkmanager.enable = true;

  time.timeZone = "Europe/Tallinn";

  i18n.defaultLocale = "en_US.UTF-8";

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "et_EE.UTF-8";
    LC_IDENTIFICATION = "et_EE.UTF-8";
    LC_MEASUREMENT = "et_EE.UTF-8";
    LC_MONETARY = "et_EE.UTF-8";
    LC_NAME = "et_EE.UTF-8";
    LC_NUMERIC = "et_EE.UTF-8";
    LC_PAPER = "et_EE.UTF-8";
    LC_TELEPHONE = "et_EE.UTF-8";
    LC_TIME = "et_EE.UTF-8";
  };

  nix.settings.experimental-features = ["nix-command" "flakes"];

  services.xserver.enable = true;
  services.displayManager.sddm.enable = true;
  services.displayManager.sddm.wayland.enable = true;
  programs.hyprland.enable = true;

  services.xserver.xkb = {
    layout = "us";
    variant = "";
  };

  services.printing.enable = true;
  services.blueman.enable = true;
  services.gvfs.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    wireplumber.extraConfig = {
      "50-bluez" = {
        "monitor.bluez.rules" = [
          {
            matches = [{"device.name" = "~bluez_card.*";}];
            actions = {
              update-props = {
                "bluez5.reconnect-profiles" = [
                  "hfp_hf"
                  "hsp_hs"
                  "a2dp_sink"
                ];
                "bluez5.msbc-support" = true;
                "bluez5.sbc-xq-support" = true;
              };
            };
          }
          {
            matches = [
              # Matches all sources
              {"node.name" = "~bluez_input.*";}
              # Matches all outputs
              {"node.name" = "~bluez_output.*";}
            ];
            actions = {
              "node.pause-on-idle" = false;
            };
          }
        ];
        "monitor.bluez.properties" = {
          "bluez5.roles" = [
            "a2dp_sink"
            "a2dp_source"
            "bap_sink"
            "bap_source"
          ];

          "bluez5.codecs" = [
            "ldac"
            "aptx"
            "aptx_ll_duplex"
            "aptx_ll"
            "aptx_hd"
            "opus_05_pro"
            "opus_05_71"
            "opus_05_51"
            "opus_05"
            "opus_05_duplex"
            "aac"
            "sbc_xq"
          ];

          "bluez5.hfphsp-backend" = "none";
        };
      };
    };
  };
  hardware.bluetooth = {
    enable = true;
    settings = {
      General = {
        Enable = "Source,Sink,Media,Socket";
        Name = "NixOS";
        ControllerMode = "dual";
        FastConnectable = "true";
        Experimental = "true";
      };
      Policy = {
        AutoEnable = "true";
      };
    };
  };
  hardware.enableAllFirmware = true;

  hardware.graphics.enable = true;
  security.rtkit.enable = true;
  security.polkit.enable = true;
  security.pam.services = {
    sddm.text = pkgs.lib.mkBefore ''
      auth      include   login
    '';
  };

  services.syncthing = {
    enable = true;
    user = "drigster";
    dataDir = "/home/drigster/Documents";
    configDir = "/home/drigster/.config/syncthing";
  };

  services.syncthing.settings.gui = {
    user = "drigster";
    password = "drigster";
  };

  systemd = {
    user.services.mpris-proxy = {
      description = "Mpris proxy";
      after = ["network.target" "sound.target"];
      wantedBy = ["default.target"];
      serviceConfig.ExecStart = "${pkgs.bluez}/bin/mpris-proxy";
    };

    user.services.polkit-gnome-authentication-agent-1 = {
      description = "polkit-gnome-authentication-agent-1";
      wantedBy = ["graphical-session.target"];
      wants = ["graphical-session.target"];
      after = ["graphical-session.target"];
      serviceConfig = {
        Type = "simple";
        ExecStart = "${pkgs.polkit_gnome}/libexec/polkit-gnome-authentication-agent-1";
        Restart = "on-failure";
        RestartSec = 1;
        TimeoutStopSec = 10;
      };
    };
    extraConfig = ''
      DefaultTimeoutStopSec=10s
    '';
  };

  users.users.drigster = {
    isNormalUser = true;
    description = "Drigster";
    extraGroups = ["networkmanager" "wheel"];
  };

  nixpkgs.config.allowUnfree = true;

  home-manager = {
    extraSpecialArgs = {inherit inputs;};
    useGlobalPkgs = true;
    useUserPackages = true;
    backupFileExtension = "backup";
    users = {
      "drigster" = import ./../home-manager/home.nix;
    };
  };

  programs.firefox.enable = true;

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages =
    (with pkgs; [
      dunst
      ark
      kitty
      bun
      bat
      zoxide
      polkit_gnome
      git
      gh
      kdePackages.qt6ct
      adw-gtk3
      hyprshot
      xwaylandvideobridge
      egl-wayland
      pavucontrol
      pamixer
      btop
      alejandra
      dconf
      networkmanager
      nodejs
      pnpm
      networkmanagerapplet
      xdg-desktop-portal-gtk
      xdg-desktop-portal-hyprland
      nodePackages_latest.prisma
      nemo-with-extensions

      qpwgraph
      python312Full
      python312Packages.pip
      (jdk21.override {enableJavaFX = true;})
      jdk17
      clamav
      libreoffice

      prisma-engines
      gimp
      thunderbird
      qbittorrent

      xorg.libX11
      xorg.libXrandr
      xorg.libXcursor
      xorg.libxcb
      libGL
      glfw
      glfw-wayland
      libpulseaudio
      wireguard-tools
      xclicker
      syncthing
      fastfetch
      brightnessctl
      unityhub
    ])
    ++ (with pkgsUnstable; [
      ]);

  environment.variables.PRISMA_QUERY_ENGINE_LIBRARY = "${pkgs.prisma-engines}/lib/libquery_engine.node";
  environment.variables.PRISMA_QUERY_ENGINE_BINARY = "${pkgs.prisma-engines}/bin/query-engine";
  environment.variables.PRISMA_SCHEMA_ENGINE_BINARY = "${pkgs.prisma-engines}/bin/schema-engine";

  services.resolved.enable = true;
  services.pipewire.extraConfig.pipewire."91-null-sinks" = {
    "context.objects" = [
      {
        # A default dummy driver. This handles nodes marked with the "node.always-driver"
        # properyty when no other driver is currently active. JACK clients need this.
        factory = "spa-node-factory";
        args = {
          "factory.name" = "support.node.driver";
          "node.name" = "Dummy-Driver";
          "priority.driver" = 8000;
        };
      }
      {
        factory = "adapter";
        args = {
          "factory.name" = "support.null-audio-sink";
          "node.name" = "Mic";
          "node.description" = "Mic";
          "media.class" = "Audio/Source/Virtual";
          "audio.position" = "FL,FR";
        };
      }
      {
        factory = "adapter";
        args = {
          "factory.name" = "support.null-audio-sink";
          "node.name" = "Game";
          "node.description" = "Game";
          "media.class" = "Audio/Sink";
          "audio.position" = "FL,FR";
        };
      }
      {
        factory = "adapter";
        args = {
          "factory.name" = "support.null-audio-sink";
          "node.name" = "Chat";
          "node.description" = "Chat";
          "media.class" = "Audio/Sink";
          "audio.position" = "FL,FR";
        };
      }
      {
        factory = "adapter";
        args = {
          "factory.name" = "support.null-audio-sink";
          "node.name" = "Media";
          "node.description" = "Media";
          "media.class" = "Audio/Sink";
          "audio.position" = "FL,FR";
        };
      }
    ];
  };

  programs.steam = {
    enable = true;
    remotePlay.openFirewall = true; # Open ports in the firewall for Steam Remote Play
    dedicatedServer.openFirewall = true; # Open ports in the firewall for Source Dedicated Server
    localNetworkGameTransfers.openFirewall = true; # Open ports in the firewall for Steam Local Network Game Transfers
  };
  programs.gamemode.enable = true;

  nixpkgs.config.permittedInsecurePackages = [
    "openssl-1.1.1w"
  ];

  fonts.packages = with pkgs; [
    noto-fonts
    noto-fonts-cjk-sans
    noto-fonts-emoji
    (nerdfonts.override {fonts = ["FiraCode" "NerdFontsSymbolsOnly"];})
    texlivePackages.inter
  ];

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "24.05"; # Did you read the comment?
}
