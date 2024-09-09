{
  pkgs,
  lib,
  config,
  ...
}: {
  options = {
    nvidia.enable = lib.mkEnableOption "enables nvidia";
  };

  config = lib.mkIf config.nvidia.enable {
    hardware = {
      nvidia = {
        modesetting.enable = true;
        powerManagement.enable = false;
        powerManagement.finegrained = false;
        open = false;
        nvidiaSettings = true;
        package = config.boot.kernelPackages.nvidiaPackages.stable;
      };
      graphics = {
        enable = true;
        extraPackages = with pkgs; [
          nvidia-vaapi-driver
          vaapiVdpau
          libvdpau-va-gl
        ];
      };
    };

    services.xserver.videoDrivers = ["nvidia"];
  };
}
