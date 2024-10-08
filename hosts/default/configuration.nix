{
  config,
  pkgs,
  inputs,
  ...
}: {
  imports = [
    ./hardware-configuration.nix
    ./../../modules/nixos/configuration.nix
    ./../../modules/nixos/nvidia.nix
  ];

  fileSystems."/mnt/backup" = {
    device = "unraid:/mnt/user/Backup";
    fsType = "nfs";
    options = ["nfsvers=4.2" "x-systemd.automount" "noauto" "x-systemd.idle-timeout=600"];
  };
  fileSystems."/mnt/media" = {
    device = "unraid:/mnt/user/Media";
    fsType = "nfs";
    options = ["nfsvers=4.2" "x-systemd.automount" "noauto" "x-systemd.idle-timeout=600"];
  };

  nvidia.enable = true;
}
