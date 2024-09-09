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

  nvidia.enable = true;
}
